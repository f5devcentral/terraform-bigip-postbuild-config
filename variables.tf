variable "bigip_user" {
    description = "account to use with the BIG-IP"
    type        = string
}
variable "bigip_password" {
    description = "password of `bigip_user` account"
    type        = string
}
variable "bigip_address" {
    description = "FQDN or ip address of the BIG-IP"
    type        = string
}
variable "bigip_atc_payload" {
    description = "BIG-IP Automation Toolchain JSON payload - Declarative Onboarding (DO), Application Services (AS3), or other as appropriate"
    type        = string
}

variable "bigip_atc_endpoint" {
    description = "ATC endpoint to receive POSTs or GETs. The submodules (`//do` `//as3`) have these values defined."
    type        = string
}
variable "bigip_atc_status_endpoint" {
  description = "ATC endpoint for checking the status of the service. The submodules (`//do` `//as3`) have these values defined."
  type        = string
}
variable "initial_wait" {
  description = "time to wait before polling endpoint"
  default     = 30
  type        = number
}
variable "poll_interval" {
  description = "time between polling events"
  default     = 40
  type        = number
}
variable "retry_limit" {
  description = "maximum number of attempts before exiting with an error"
  default     = 10
  type        = number
}
variable "wait_for_completion" {
  type        = bool
  description = "if `true`, the module polls the service endpoint for a 200 response before exiting. if `false`, the module exits immeidately in case of and 2xx response."
  default     = true
}

variable "trigger_on_payload" {
  type        = bool
  description = "if `true`, the payload is sent to the endpoint during any `terraform apply` if the payload content has changed. if `false`, the payload is sent to the endpoint only during the first `terraform apply`"
  default     = true
}

variable "shellscript" {
  type        = bool
  description = "upload and run a shell script"
  default     = false
}
variable "additional_file_content" {
  type        = string
  description = "content for an additional file to place on the BIG-IP"
  default     = ""
}
variable "additional_file_destination" {
  type        = string
  description = "destination for an additional file to place on the BIG-IP. used in tandem with additional_file_content"
  default     = ""
}