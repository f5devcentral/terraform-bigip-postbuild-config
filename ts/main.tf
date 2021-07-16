variable "bigip_user" {
    description = "account to use with the BIG-IP"
}
variable "bigip_password" {
    description = "password for BIG-IP account"
}
variable "bigip_address" {
    description = "FQDN or ip address for BIG-IP"
}
variable "bigip_as3_payload" {
    description = "Telemetry Streaming (TS) JSON payload"
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
module "bigip_atc" {
    source                    = "../"
    bigip_user                = var.bigip_user
    bigip_password            = var.bigip_password
    bigip_address             = var.bigip_address
    bigip_atc_payload         = var.bigip_as3_payload
    bigip_atc_endpoint        = "/mgmt/shared/telemetry"
    bigip_atc_status_endpoint = "/mgmt/shared/telemetry/info"
    initial_wait              = var.initial_wait
    wait_for_completion       = var.wait_for_completion
    trigger_on_payload        = var.trigger_on_payload
}