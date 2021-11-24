# Usage
This module uses remote-exec on the BIG-IP. For this to work the admin user (or whatever user with which we're connecting to the BIG-IP) must have its default shell set to ```bash``` rather than ```tmsh```. This can be accomplished by sending a Declarative Onboarding declaration, including account configuration, before the shell script with an appropriate ```depends_on``` stanza.

For example,
```hcl
module "postbuild-config-do" {
  source           = "mjmenger/postbuild-config//do"
  version          = "0.5.1"
  bigip_user       = module.bigip[0].f5_username
  bigip_password   = module.bigip[0].bigip_password
  bigip_address    = module.bigip[0].mgmtPublicIP
  bigip_do_payload = var.dopayload
  depends_on = [
    module.bigip
  ]
}

module "postbuild-config-sh" {
  source              = "mjmenger/postbuild-config//sh"
  version             = "0.5.1"
  bigip_user          = module.bigip[0].f5_username
  bigip_password      = module.bigip[0].bigip_password
  bigip_address       = module.bigip[0].mgmtPublicIP
  bigip_shell_payload = var.shellscriptcontent
  depends_on = [
    module.postbuild-config-do
  ]
}

```


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
| <a name="input_additional_file_content"></a> [additional\_file\_content](#input\_additional\_file\_content) | additional | `string` | `""` | no |
| <a name="input_additional_file_destination"></a> [additional\_file\_destination](#input\_additional\_file\_destination) | additional file destination | `string` | `""` | no |
| <a name="input_bigip_address"></a> [bigip\_address](#input\_bigip\_address) | FQDN or ip address for BIG-IP | `any` | n/a | yes |
| <a name="input_bigip_password"></a> [bigip\_password](#input\_bigip\_password) | password for BIG-IP account | `any` | n/a | yes |
| <a name="input_bigip_shell_payload"></a> [bigip\_shell\_payload](#input\_bigip\_shell\_payload) | shell script payload | `any` | n/a | yes |
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
| <a name="input_additional_file_content"></a> [additional\_file\_content](#input\_additional\_file\_content) | additional | `string` | `""` | no |
| <a name="input_additional_file_destination"></a> [additional\_file\_destination](#input\_additional\_file\_destination) | additional file destination | `string` | `""` | no |
| <a name="input_bigip_address"></a> [bigip\_address](#input\_bigip\_address) | FQDN or ip address for BIG-IP | `any` | n/a | yes |
| <a name="input_bigip_password"></a> [bigip\_password](#input\_bigip\_password) | password for BIG-IP account | `any` | n/a | yes |
| <a name="input_bigip_shell_payload"></a> [bigip\_shell\_payload](#input\_bigip\_shell\_payload) | shell script payload | `any` | n/a | yes |
| <a name="input_bigip_user"></a> [bigip\_user](#input\_bigip\_user) | account to use with the BIG-IP | `any` | n/a | yes |
| <a name="input_initial_wait"></a> [initial\_wait](#input\_initial\_wait) | time to wait before probing endpoint | `number` | `30` | no |
| <a name="input_trigger_on_payload"></a> [trigger\_on\_payload](#input\_trigger\_on\_payload) | resend the payload if the payload content has changed since the last apply | `bool` | `true` | no |
| <a name="input_wait_for_completion"></a> [wait\_for\_completion](#input\_wait\_for\_completion) | in case of 202 response poll for 200 before completion | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->