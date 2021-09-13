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