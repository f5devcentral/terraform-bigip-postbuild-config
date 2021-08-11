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

variable "shellscript" {
  type        = bool
  description = "upload and run a shell script"
  default     = false
}
variable "additional_file_content" {
  type        = string
  description = "additional "
  default     = ""
}
variable "additional_file_destination" {
  type        = string
  description = "additional file destination"
  default     = ""
}