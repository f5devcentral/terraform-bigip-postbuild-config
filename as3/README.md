# Usage

<!--- BEGIN_TF_DOCS --->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bigip_atc"></a> [bigip\_atc](#module\_bigip\_atc) | ../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bigip_address"></a> [bigip\_address](#input\_bigip\_address) | FQDN or ip address for BIG-IP | `any` | n/a | yes |
| <a name="input_bigip_as3_payload"></a> [bigip\_as3\_payload](#input\_bigip\_as3\_payload) | Declarative Onboarding (DO) JSON payload | `any` | n/a | yes |
| <a name="input_bigip_password"></a> [bigip\_password](#input\_bigip\_password) | password for BIG-IP account | `any` | n/a | yes |
| <a name="input_bigip_user"></a> [bigip\_user](#input\_bigip\_user) | account to use with the BIG-IP | `any` | n/a | yes |
| <a name="input_initial_wait"></a> [initial\_wait](#input\_initial\_wait) | time to wait before probing endpoint | `number` | `30` | no |
| <a name="input_trigger_on_payload"></a> [trigger\_on\_payload](#input\_trigger\_on\_payload) | resend the payload if the payload content has changed since the last apply | `bool` | `true` | no |
| <a name="input_wait_for_completion"></a> [wait\_for\_completion](#input\_wait\_for\_completion) | in case of 202 response poll for 200 before completion | `bool` | `true` | no |

## Outputs

No outputs.

<!--- END_TF_DOCS --->


<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bigip_atc"></a> [bigip\_atc](#module\_bigip\_atc) | ../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bigip_address"></a> [bigip\_address](#input\_bigip\_address) | FQDN or ip address for BIG-IP | `any` | n/a | yes |
| <a name="input_bigip_as3_payload"></a> [bigip\_as3\_payload](#input\_bigip\_as3\_payload) | Declarative Onboarding (DO) JSON payload | `any` | n/a | yes |
| <a name="input_bigip_password"></a> [bigip\_password](#input\_bigip\_password) | password for BIG-IP account | `any` | n/a | yes |
| <a name="input_bigip_user"></a> [bigip\_user](#input\_bigip\_user) | account to use with the BIG-IP | `any` | n/a | yes |
| <a name="input_initial_wait"></a> [initial\_wait](#input\_initial\_wait) | time to wait before probing endpoint | `number` | `30` | no |
| <a name="input_trigger_on_payload"></a> [trigger\_on\_payload](#input\_trigger\_on\_payload) | resend the payload if the payload content has changed since the last apply | `bool` | `true` | no |
| <a name="input_wait_for_completion"></a> [wait\_for\_completion](#input\_wait\_for\_completion) | in case of 202 response poll for 200 before completion | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
