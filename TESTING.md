tested using 
- Terraform 0.15.5
- Kitchen 2.12.0
- kitchen-terraform 5.8.0

## Setup the testing host
- Follow the [Kitchen-Terraform instructions](https://github.com/newcontext-oss/kitchen-terraform/blob/master/README.md#installation)
- The ```Gemfile``` referenced in the Bundler step is already provided in this repository

## Setup credentials
- Setup AWS credentials using either the [Environment Variables approach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication) or the [Credentials File approach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#shared-credentials-file)
- Setup Azure credentials using the [Azure CLI approach](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli). Note: The [other appraoches](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret) may work, I have not tried them.

## Setup Terraform input
- create ```aws.tfvars``` from [aws.tfvars.example](test/assets/aws.tfvars.example)
- create ```azure.tfvars``` from [azure.tfvars.example](test/assets/aws.tfvars.example)

## First time through
You should be good to go now.

```bash
bundle exec kitchen converge aws
bundle exec kitchen verify aws
bundle exec kitchen destroy aws
```
```bash
bundle exec kitchen converge azure
bundle exec kitchen verify azure
bundle exec kitchen destroy azure
```

## Streamlining
The following performs all three of the steps above. It abends if any of the three steps fails. 
```
bundle exec kitchen test aws

bundle exec kitchen test azure
```