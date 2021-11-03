variable "prefix" {
  default = "kitchen-terraform"
}
## Europe Regions need oder Jumphost and BigIP Instance Typs1
## Uncomment needed region below

# US (Oregon)
variable "region" {
  default = "us-west-2"
}

variable "azs" {
  default = ["us-west-2a", "us-west-2b"]
}

variable "ec2_bigip_type" {
  default = "c4.xlarge"
}
variable "ec2_ubuntu_type" {
  default = "t2.xlarge"
}

variable "cidr" {
  description = "addresses for the virtual network"
  default     = "10.0.0.0/16"
}

variable "allowed_mgmt_cidr" {
  description = "list of source addresses allowed access to the BIG-IP management port"
  default = ["0.0.0.0/0", "10.0.0.0/8"]
}

variable "allowed_app_cidr" {
  default = "0.0.0.0/0"
}

variable "management_subnet_offset" {
  default = 10
}

variable "external_subnet_offset" {
  default = 0
}

variable "internal_subnet_offset" {
  default = 20
}

variable "ec2_key_name" {
}

variable "ec2_key_file" {
}

variable "nameserver" {
  default = "8.8.8.8"
}
variable do_version {
  default = "1.21.0"
}

variable as3_version {
  default = "3.28.0"
}

variable ts_version {
  default = "1.20.0"
}

variable fast_version {
  default = "1.9.0"
}

variable internal_selfip_address {
  default = "10.30.0.10/24"
}
variable external_selfip_address {
  default = "10.20.0.9/24"
}
variable mtu_size {
  default = 1500 
}
variable internal_vlan_tag {
  default = "20"
}
variable external_vlan_tag {
  default = "10"
}
variable internal_vlan_name {
  default = "1.2"
}
variable external_vlan_name {
  default = "1.1"
}