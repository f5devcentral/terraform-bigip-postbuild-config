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
    description = "Declarative Onboarding (DO) JSON payload"
}
variable "initial_wait" {
    description = "time to wait before probing endpoint"
    default     = 30
}
module "bigip_atc" {
    source                    = "../"
    bigip_user                = var.bigip_user
    bigip_password            = var.bigip_password
    bigip_address             = var.bigip_address
    bigip_atc_payload         = var.bigip_as3_payload
    bigip_atc_endpoint        = "/mgmt/shared/appsvcs/declare"
    bigip_atc_status_endpoint = "/mgmt/shared/appsvcs/declare"
    initial_wait              = var.initial_wait
}