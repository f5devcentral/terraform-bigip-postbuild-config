variable "bigip_user" {
    description = "account to use with the BIG-IP"
}
variable "bigip_password" {
    description = "password for BIG-IP account"
}
variable "bigip_address" {
    description = "FQDN or ip address for BIG-IP"
}
variable "bigip_shell_payload" {
    description = "shell script payload"
}
variable "initial_wait" {
    description = "time to wait before probing endpoint"
    default     = 30
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
module "bigip_atc" {
    source                      = "../"
    bigip_user                  = var.bigip_user
    bigip_password              = var.bigip_password
    bigip_address               = var.bigip_address
    bigip_atc_payload           = var.bigip_shell_payload
    bigip_atc_endpoint          = "/mgmt/shared/declarative-onboarding"
    bigip_atc_status_endpoint   = "/mgmt/shared/declarative-onboarding/info"
    initial_wait                = var.initial_wait
    wait_for_completion         = var.wait_for_completion
    trigger_on_payload          = var.trigger_on_payload
    shellscript                 = true
    additional_file_content     = var.additional_file_content
    additional_file_destination = var.additional_file_destination
}