# Overview

For large-scale or dynamically-scaled BIG-IP deployments, the current [BIG-IP provider](https://registry.terraform.io/providers/F5Networks/bigip/latest/docs) is not an option for [Application Services (AS3)](https://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/latest/) and [Declarative Onboarding (DO)](https://clouddocs.f5.com/products/extensions/f5-declarative-onboarding/latest/) calls. This module is a workaround to address the following use-cases:

- Using Terraform to build and onboard more than one or two BIG-IPs simultaneously
- Using Terraform to build, onboard, and operate a dynamically- and arbitrarily-sized cluster of BIG-IPs
- Using Terraform to reconfigure BIG-IPs after initial build and onboarding when source-controlled operating parameters have changed

# Prerequisites
- Terraform host must be able to run a shell script 
- curl must be installed on the Terraform host
- The Terraform host must be able to access the management endpoint of the BIG-IPs to configure

By using the submodules described below, the required inputs ```bigip_atc_endpoint ```, ```bigip_atc_payload ```, and ```bigip_atc_status_endpoint ``` are addressed with defaults.

## Submodules for specific use-cases
| Name | source URL | Description |
|------|-----|-------------|
|[AS3](as3/)|https://github.com/mjmenger/terraform-bigip-postbuild-config//as3|addresses defaults required to send AS3 declarations|
|[DO](dos/)|https://github.com/mjmenger/terraform-bigip-postbuild-config//do|addresses defaults required to send DO declarations|
|[SH](sh/)|https://github.com/mjmenger/terraform-bigip-postbuild-config//sh|addresses defaults required to send and execute bash scripts|


# Usage


<!--- BEGIN_TF_DOCS --->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.bigip_atc](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.bigip_atc_additional_file](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.bigip_atc_shell](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.bigip_atc_wait](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_file_content"></a> [additional\_file\_content](#input\_additional\_file\_content) | content for an additional file to place on the BIG-IP | `string` | `""` | no |
| <a name="input_additional_file_destination"></a> [additional\_file\_destination](#input\_additional\_file\_destination) | destination for an additional file to place on the BIG-IP. used in tandem with additional\_file\_content | `string` | `""` | no |
| <a name="input_bigip_address"></a> [bigip\_address](#input\_bigip\_address) | FQDN or ip address of the BIG-IP | `string` | n/a | yes |
| <a name="input_bigip_atc_endpoint"></a> [bigip\_atc\_endpoint](#input\_bigip\_atc\_endpoint) | ATC endpoint to receive POSTs or GETs. The submodules (`//do` `//as3`) have these values defined. | `string` | n/a | yes |
| <a name="input_bigip_atc_payload"></a> [bigip\_atc\_payload](#input\_bigip\_atc\_payload) | BIG-IP Automation Toolchain JSON payload - Declarative Onboarding (DO), Application Services (AS3), or other as appropriate | `string` | n/a | yes |
| <a name="input_bigip_atc_status_endpoint"></a> [bigip\_atc\_status\_endpoint](#input\_bigip\_atc\_status\_endpoint) | ATC endpoint for checking the status of the service. The submodules (`//do` `//as3`) have these values defined. | `string` | n/a | yes |
| <a name="input_bigip_password"></a> [bigip\_password](#input\_bigip\_password) | password of `bigip_user` account | `string` | n/a | yes |
| <a name="input_bigip_user"></a> [bigip\_user](#input\_bigip\_user) | account to use with the BIG-IP | `string` | n/a | yes |
| <a name="input_initial_wait"></a> [initial\_wait](#input\_initial\_wait) | time to wait before polling endpoint | `number` | `30` | no |
| <a name="input_poll_interval"></a> [poll\_interval](#input\_poll\_interval) | time between polling events | `number` | `40` | no |
| <a name="input_retry_limit"></a> [retry\_limit](#input\_retry\_limit) | maximum number of attempts before exiting with an error | `number` | `10` | no |
| <a name="input_shellscript"></a> [shellscript](#input\_shellscript) | upload and run a shell script | `bool` | `false` | no |
| <a name="input_trigger_on_payload"></a> [trigger\_on\_payload](#input\_trigger\_on\_payload) | if `true`, the payload is sent to the endpoint during any `terraform apply` if the payload content has changed. if `false`, the payload is sent to the endpoint only during the first `terraform apply` | `bool` | `true` | no |
| <a name="input_wait_for_completion"></a> [wait\_for\_completion](#input\_wait\_for\_completion) | if `true`, the module polls the service endpoint for a 200 response before exiting. if `false`, the module exits immeidately in case of and 2xx response. | `bool` | `true` | no |

## Outputs

No outputs.

<!--- END_TF_DOCS --->

