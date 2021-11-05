# terraform-bigip-postbuild-config

For large-scale or dynamically-scaled BIG-IP deployments, the current [BIG-IP provider](https://registry.terraform.io/providers/F5Networks/bigip/latest/docs) is not an option for [Application Services (AS3)](https://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/latest/) and [Declarative Onboarding (DO)](https://clouddocs.f5.com/products/extensions/f5-declarative-onboarding/latest/) calls. This module is a workaround to address the following use-cases:

- Using Terraform to build and onboard more than one or two BIG-IPs simultaneously
- Using Terraform to build, onboard, and operate a dynamically- and arbitrarily-sized cluster of BIG-IPs
- Using Terraform to reconfigure BIG-IPs after initial build and onboarding when source-controlled operating parameters have changed

# Prerequisites
- Terraform host must be able to run a shell script 
- curl must be installed on the Terraform host
- The Terraform host must be able to access the management endpoint of the BIG-IPs to configure

By using the submodules described below, the required inputs ```bigip_atc_endpoint ```, ```bigip_atc_payload ```, and ```bigip_atc_status_endpoint ``` are addressed with defaults.

## Simple Declarative On-boarding example

```hcl
module "postbuild-config-do" {
  source           = "mjmenger/postbuild-config/bigip//do"
  version          = "0.1.0"
  bigip_user       = "admin"
  bigip_password   = "supersecretpassword"
  bigip_address    = "addressofbigip"
  bigip_do_payload = "dojsonpayload"
}
```

## Simple AS3 example

```hcl
module "postbuild-config-as3" {
  source            = "mjmenger/postbuild-config/bigip//as3"
  version           = "0.1.0"
  bigip_user        = "admin"
  bigip_password    = "supersecretpassword"
  bigip_address     = "addressofbigip"
  bigip_as3_payload = "as3jsonpayload"
}
```

## Declarative On-boarding with arbitrary number of BIG-IPs

```hcl
module "postbuild-config-do" {
  count            = var.bigip_count
  source           = "mjmenger/postbuild-config/bigip//do"
  version          = "0.1.0"
  bigip_user       = "admin"
  bigip_password   = "supersecretpassword"
  bigip_address    = var.listofbigipaddresses[count.index]
  bigip_do_payload = var.listofdopayload[count.index]
}
```

## Declarative On-boarding in which declarations are only sent on the first apply
```hcl
module "postbuild-config-do" {
  count              = var.bigip_count
  source             = "mjmenger/postbuild-config/bigip//do"
  version            = "0.1.0"
  bigip_user         = "admin"
  bigip_password     = "supersecretpassword"
  bigip_address      = var.listofbigipaddresses[count.index]
  bigip_do_payload   = var.listofdopayload[count.index]
  trigger_on_payload = false
}
```

# Workflow of the module

The module performs the following steps:

1. Polls the target service until it's available
2. Polls the target service until it's not in use  
This step is to avoid first on-boarding race conditions
3. Post the payload to the target service and evaluate the response
4. Optionally, polls the target service for completion in case the initial response was "In Progress" (202)

Steps 1., 2., and 4. will exit with an error code in case of a timeout without a positive response
