module "bigip" {
  source                     = "git::git@github.com:f5devcentral/terraform-aws-bigip-module.git?ref=v0.9.4"
  count                      = length(var.azs)
  prefix                     = format("%s-3nic", var.prefix)
  f5_ami_search_name         = "F5 BIGIP-15.* PAYG-Best 200Mbps*"
  f5_password                = random_string.password.result
  ec2_key_name               = aws_key_pair.deployer.key_name
  mgmt_subnet_ids            = [{ "subnet_id" = module.vpc.database_subnets[count.index], "public_ip" = true, "private_ip_primary" = "", "private_ip_secondary" = "" }]
  mgmt_securitygroup_ids     = [module.bigip_mgmt_sg.this_security_group_id]
  external_subnet_ids        = [{ "subnet_id" = module.vpc.public_subnets[count.index], "public_ip" = true, "private_ip_primary" = "", "private_ip_secondary" = "" }]
  external_securitygroup_ids = [module.bigip_sg.this_security_group_id, module.bigip_mgmt_sg.this_security_group_id]
  #external_alias_ip_count   = 2
  internal_subnet_ids        = [{ "subnet_id" = module.vpc.private_subnets[count.index], "public_ip" = false, "private_ip_primary" = "" }]
  internal_securitygroup_ids = [module.bigip_sg.this_security_group_id, module.bigip_mgmt_sg.this_security_group_id]
  DO_URL                     = "https://github.com/F5Networks/f5-declarative-onboarding/releases/download/v1.24.0/f5-declarative-onboarding-1.24.0-6.noarch.rpm"
}

resource "null_resource" "testscript" {
  count = length(var.azs)
  provisioner "file" {
    content     = <<EOT
trap "exit" INT TERM ERR
trap "kill 0" EXIT
tcpdump -i 0.0 -nnn proto GRE &
ping ${cidrhost("192.168.100.0/16",10 + (count.index == 0 ? 1 : 0))} -c 1 
    EOT
    destination = "~/gretest.sh"
  }  
  connection {
    type        = "ssh"
    user        = "admin"
    private_key = tls_private_key.keypair.private_key_pem
    host        = module.bigip[count.index].mgmtPublicIP[0]
  }
  depends_on = [
    module.postbuild-config-do
  ]
  triggers = {
    content = 321
  }
}
locals {  
  gre_remote_host = "/tmp/gre-remote-host"
}
resource "null_resource" "gre_remote_host" {
  count = length(var.azs)
  provisioner "file" {
    content     = cidrhost("192.168.100.0/16",10 + (count.index == 0 ? 1 : 0))
    destination = local.gre_remote_host
  }  
  connection {
    type        = "ssh"
    user        = "admin"
    private_key = tls_private_key.keypair.private_key_pem
    host        = module.bigip[count.index].mgmtPublicIP[0]
  }
  depends_on = [
    module.postbuild-config-do
  ]
  triggers = {
    content = 321
  }
}