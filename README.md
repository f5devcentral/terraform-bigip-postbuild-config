# terraform-bigip-postbuild-config

For large scale or dynamically scaled BIG-IP deployments, the current BIG-IP provider is not an option for Application Services (AS3) and Declarative Onboarding (DO) calls. This module is a workaround to address the following use-cases:

- Using Terraform to build and onboard more than one or two BIG-IPs simultaneously
- Using Terraform to build, onboard, and operate a dynamically- and arbitrarily-sized cluster of BIG-IPs
- Using Terraform to reconfig BIG-IPs after initial build and onboarding when operating parameters have changed

## Simple Declarative On-boarding example

```hcl
module "postbuild-config-do" {
  source  = "mjmenger/postbuild-config/bigip//do"
  version = "0.0.1"
  bigip_user          = "admin"
  bigip_password      = "supersecretpassword"
  bigip_address       = "addressofbigip"
  bigip_do_payload    = "dojsonpayload" 
}
```

## Simple AS3 example

```hcl
module "postbuild-config-as3" {
  source  = "mjmenger/postbuild-config/bigip//as3"
  version = "0.0.1"
  bigip_user          = "admin"
  bigip_password      = "supersecretpassword"
  bigip_address       = "addressofbigip"
  bigip_as3_payload    = "as3jsonpayload" 
}
```