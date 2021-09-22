module "bigip" {
  source                     = "git::git@github.com:f5devcentral/terraform-aws-bigip-module.git?ref=v0.9.7"
  count                      = 1
  prefix                     = format("%s-3nic", var.prefix)
  f5_ami_search_name         = "F5 BIGIP-15.* PAYG-Best 200Mbps*"
  f5_password                = random_string.password.result
  ec2_key_name               = var.ec2_key_name
  mgmt_subnet_ids            = [{ "subnet_id" = module.vpc.database_subnets[count.index], "public_ip" = true, "private_ip_primary" = "", "private_ip_secondary" = "" }]
  mgmt_securitygroup_ids     = [module.bigip_mgmt_sg.this_security_group_id]
  external_subnet_ids        = [{ "subnet_id" = module.vpc.public_subnets[count.index], "public_ip" = true, "private_ip_primary" = "", "private_ip_secondary" = "" }]
  external_securitygroup_ids = [module.bigip_sg.this_security_group_id, module.bigip_mgmt_sg.this_security_group_id]
  #external_alias_ip_count   = 2
  internal_subnet_ids        = [{ "subnet_id" = module.vpc.private_subnets[count.index], "public_ip" = false, "private_ip_primary" = "" }]
  internal_securitygroup_ids = [module.bigip_sg.this_security_group_id, module.bigip_mgmt_sg.this_security_group_id]
}