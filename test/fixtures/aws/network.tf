module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                 = format("%s-vpc-%s", var.prefix, random_id.id.hex)
  cidr                 = var.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  azs = var.azs

  # vpc public subnet used for external interface
  public_subnets = [for num in range(length(var.azs)) :
    cidrsubnet(var.cidr, 8, num + var.external_subnet_offset)
  ]

  # vpc private subnet used for internal 
  private_subnets = [
    for num in range(length(var.azs)) :
    cidrsubnet(var.cidr, 8, num + var.internal_subnet_offset)
  ]

  enable_nat_gateway = true

  # using the database subnet method since it allows a public route
  database_subnets = [
    for num in range(length(var.azs)) :
    cidrsubnet(var.cidr, 8, num + var.management_subnet_offset)
  ]
  create_database_subnet_group           = true
  create_database_subnet_route_table     = true
  create_database_internet_gateway_route = true

  tags = {
    Name        = format("%s-vpc-%s", var.prefix, random_id.id.hex)
    Terraform   = "true"
    Environment = "dev"
  }
}

module "bigip_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  name        = format("%s-bigip-%s", var.prefix, random_id.id.hex)
  description = "Security group for BIG-IP Demo"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = [var.allowed_app_cidr]
  ingress_rules       = ["http-80-tcp", "https-443-tcp"]

  ingress_with_source_security_group_id = [
    {
      rule                     = "all-all"
      source_security_group_id = module.bigip_sg.this_security_group_id
    }
  ]

  # Allow ec2 instances outbound Internet connectivity
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]
}

#
# Create a security group for BIG-IP Management
#
module "bigip_mgmt_sg" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "3.18.0"
  name        = format("%s-bigip-mgmt-%s", var.prefix, random_id.id.hex)
  description = "Security group for BIG-IP Demo"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = var.allowed_mgmt_cidr
  ingress_rules       = ["https-443-tcp", "https-8443-tcp", "ssh-tcp"]

  ingress_with_source_security_group_id = [
    {
      rule                     = "all-all"
      source_security_group_id = module.bigip_mgmt_sg.this_security_group_id
    }
  ]

  # Allow ec2 instances outbound Internet connectivity
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]
}