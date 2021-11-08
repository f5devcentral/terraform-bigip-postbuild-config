variable instance_count {
  description = "Number of Bigip instances to create( From terraform 0.13, module supports count feature to spin mutliple instances )"
  type        = number
  default     = 1
}
variable prefix {
  description = "Prefix for resources created by this module"
  type        = string
  default     = "ktchntest"
}
variable project_id {
  type        = string
  description = "The GCP project identifier where the cluster will be created."
}
variable region {
  type        = string
  description = "The compute region which will host the BIG-IP VMs"
}
variable zone {
  type        = string
  default     = "us-central1-a"
  description = "The compute zones which will host the BIG-IP VMs"
}
variable image {
  type        = string
  default     = "projects/f5-7626-networks-public/global/images/f5-bigip-16-0-1-1-0-0-6-payg-good-25mbps-210129040032"
  description = "The self-link URI for a BIG-IP image to use as a base for the VM cluster.This can be an official F5 image from GCP Marketplace, or a customised image."
}

variable service_account {
  description = "service account email to use with BIG-IP vms"
  type        = string
}

variable "nameserver" {
  default = "8.8.8.8"
}

variable internal_selfip_address {
  default = "10.30.0.10/32"
}
variable external_selfip_address {
  default = "10.20.0.9/32"
}
variable mtu_size {
  default = 1460 
}
variable internal_vlan_tag {
  default = "4093"
}
variable external_vlan_tag {
  default = "4092"
}
variable internal_vlan_name {
  default = "1.2"
}
variable external_vlan_name {
  default = "1.0"
}