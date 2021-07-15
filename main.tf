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
    description = "BIG-IP Automation Toolchain JSON payload - Declarative Onboarding (DO), Application Services (AS3), or other as appropriate"
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

locals {
  atc_command = templatefile("${path.module}/atcscript.tmpl", {
    initial_wait = var.initial_wait,
    bigip_user = var.bigip_user,
    bigip_password = var.bigip_password,
    bigip_address = var.bigip_address,
    bigip_atc_status_endpoint = var.bigip_atc_status_endpoint,
    bigip_atc_endpoint = var.bigip_atc_endpoint,
    retry_limit = var.retry_limit,
    poll_interval = var.poll_interval,
    bigip_atc_payload = var.bigip_atc_payload,
    wait_for_completion = (var.wait_for_completion ? 1 : 0)
  })
}

resource "null_resource" "bigip_atc" {
  # this requires that the host executing Terraform
  # is able to communicate with the target BIG-IPs
  provisioner "local-exec" {
    command = local.atc_command
    interpreter = [
      "/bin/bash",
      "-c"
    ]
  }
  triggers = var.trigger_on_payload ? { declaration = var.bigip_atc_payload } : {}
}