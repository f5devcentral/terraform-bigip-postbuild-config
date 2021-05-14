variable "bigip_user" {
    description = "account to use with the BIG-IP"
}
variable "bigip_password" {
    description = "password for BIG-IP account"
}
variable "bigip_address" {
    description = "FQDN or ip address for BIG-IP"
}
variable "bigip_atc_payload" {
    description = "Declarative Onboarding (DO) JSON payload"
}

variable "bigip_atc_endpoint" {
    description = "atc endpoint"
}
variable "bigip_atc_status_endpoint" {
  description = "atc endpoint for service status"
}
variable "initial_wait" {
  description = "time to wait before probing endpoint"
  default     = 30
}
variable "poll_interval" {
  description = "time betweeen polling events"
  default     = 40
}
variable "retry_limit" {
  description = "maximum number of attempts before exiting"
  default     = 10
}
variable "wait_for_completion" {
  type        = bool
  description = "in case of 202 response poll for 200 before completion"
  default     = true
}

variable "trigger_on_payload" {
  type        = bool
  description = "resend the payload if the payload content has changed since the last apply"
  default     = true
}

resource "null_resource" "bigip_atc" {
  # this requires that the host executing Terraform
  # is able to communicate with the target BIG-IPs
  provisioner "local-exec" {
    command = <<-EOT
        sleep ${var.initial_wait}
        response=0
        retries=0
        echo "checking ATC service availability..."
        while [ $response -ne 200 ] && [ $retries -lt ${var.retry_limit} ]
        do
            response=$(curl -kL -u "${var.bigip_user}:${var.bigip_password}" \
              --write-out '%%{http_code}' \
              --silent \
              --output /dev/null \
              https://${var.bigip_address}${var.bigip_atc_status_endpoint}) 
            retries=$(($retries+1))
            echo "ATC endpoint for service status: $response"
            if [ $response -eq 200 ]; then
              break 
            fi
            sleep ${var.poll_interval}
        done
        if [ $response -ne 200 ]; then
          echo "ERROR: ATC SERVICE IS UNAVAILABLE"
          exit 255
        fi
        retries=0
        response=0
        while [ $response -ne 200 ] && [ $retries -lt ${var.retry_limit} ]
        do
            sleep ${var.poll_interval}
            response=$(curl -kL -u "${var.bigip_user}:${var.bigip_password}" \
              --write-out '%%{http_code}' \
              --silent \
              --output /dev/null \
              https://${var.bigip_address}${var.bigip_atc_endpoint}) 
            retries=$(($retries+1))
            echo "ATC endpoint service availability: $response"
            case $response in
              200)
                echo "ATC service available for use"
                break
                ;;
              202)
                echo "ATC service in use"
                ;;
              4* | 5*)
                echo "ATC service in failed state - this may be transient"
                ;;
              *)
                echo "unexpected ATC service availability"
                ;;
            esac
        done 
        if [ $response -ne 200 ]; then
          echo "ERROR: ATC SERVICE IS UNAVAILABLE"
          exit 255
        fi
        sleep ${var.initial_wait}
        response=$(curl -s -k -X POST https://${var.bigip_address}${var.bigip_atc_endpoint} \
              -H 'Content-Type: application/json' \
              --write-out '%%{http_code}' \
              --silent \
              --max-time 600 \
              --retry 50 \
              --retry-delay 15 \
              --retry-max-time 600 \
              --output /dev/null \
              -u "${var.bigip_user}:${var.bigip_password}" \
              -d '${var.bigip_atc_payload}')
        echo "ATC payload status: $response"
        retries=0
        while [ ${var.wait_for_completion ? 1 : 0} ] && [ $response -ne 200 ] && [ $retries -lt ${var.retry_limit} ]
        do
            sleep ${var.poll_interval}
            response=$(curl -kL -u "${var.bigip_user}:${var.bigip_password}" \
              --write-out '%%{http_code}' \
              --silent \
              --output /dev/null \
              https://${var.bigip_address}${var.bigip_atc_endpoint}) 
            retries=$(($retries+1))
            echo "ATC payload status: $response"
            case $response in
              200)
                echo "payload applied"
                break
                ;;
              202)
                echo "payload in process"
                ;;
              4* | 5*)
                echo "payload failed"
                exit 255
                ;;
              *)
                echo "unexpected response to payload"
                ;;
            esac
        done        
        EOT
  }
  triggers = var.trigger_on_payload ? { declaration = var.bigip_atc_payload } : {}
}