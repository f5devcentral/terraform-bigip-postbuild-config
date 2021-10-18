provider aws {
    region = var.region
}

#
# Create a random id
#
resource "random_id" "id" {
  byte_length = 2
}
#
# Create random password for BIG-IP
#
resource "random_string" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

locals {
    tags = merge(var.tags,{
        Terraform   = "true"
        Environment = var.environment
      }
    )
}
