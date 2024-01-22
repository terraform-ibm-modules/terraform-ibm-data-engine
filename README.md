# Data Engine (SQL Query) Module

[![Graduated (Supported)](https://img.shields.io/badge/Status-Graduated%20(Supported)-brightgreen)](https://terraform-ibm-modules.github.io/documentation/#/badge-status)
[![Build status](https://github.com/terraform-ibm-modules/terraform-ibm-data-engine/actions/workflows/ci.yml/badge.svg)](https://github.com/terraform-ibm-modules/terraform-ibm-data-engine/actions/workflows/ci.yml)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![latest release](https://img.shields.io/github/v/release/terraform-ibm-modules/terraform-ibm-data-engine?logo=GitHub&sort=semver)](https://github.com/terraform-ibm-modules/terraform-ibm-data-engine/releases/latest)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com/)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)

---

:warning: **Deprecated**: IBM Cloud® Data Engine is deprecated. As of 18 February 2024 you can't create new instances, and access to free instances will be removed. Existing Standard plan instances are supported until 18 January 2025. Any instances that still exist on that date will be deleted.

---

This module provisions an [IBM Cloud® Data Engine](https://cloud.ibm.com/docs/sql-query?topic=sql-query-getting-started) instance.

<!-- Below content is automatically populated via pre-commit hook -->
<!-- BEGIN OVERVIEW HOOK -->
## Overview
* [terraform-ibm-data-engine](#terraform-ibm-data-engine)
* [Examples](./examples)
    * [Basic Example](./examples/basic)
    * [Complete example with BYOK encryption](./examples/complete)
* [Contributing](#contributing)
<!-- END OVERVIEW HOOK -->

## terraform-ibm-data-engine
### Usage

```hcl
provider "ibm" {
  ibmcloud_api_key = "XXXXXXXXXX"
  region           = "us-south"
}

module "data_engine" {
  source  = "terraform-ibm-modules/data-engine/ibm"
  version = "latest" # Replace "latest" with a release version to lock into a specific release
  resource_group_id    = "xxXXxxXXxXxXXXXxxXxxxXXXXxXXXXX"
  region               = "us-south"
}
```

### Required IAM access policies

You need the following permissions to run this module.

- Account Management
  - **All Identity and Access Enabled** service
    - `Viewer` platform access
  - **All Resource Groups** service
    - `Viewer` platform access
- IAM Services
  - **Data Engine** service
    - `Editor` platform access
    - `Manager` service access

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0, <1.6.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.49.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.9.1 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [ibm_iam_authorization_policy.kms_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/iam_authorization_policy) | resource |
| [ibm_resource_instance.data_engine_instance](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/resource_instance) | resource |
| [time_sleep.wait_for_authorization_policy](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_existing_kms_instance_guid"></a> [existing\_kms\_instance\_guid](#input\_existing\_kms\_instance\_guid) | The GUID the Key Protect instance in which the key specified in var.kms\_key\_crn is coming from. Required only if var.kms\_encryption\_enabled is set to true, var.skip\_iam\_authorization\_policy is set to false. NOTE: Hyper Protect Crypto Services is not currently supported by Data Engine. | `string` | `null` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | The name to give the Data Engine instance. | `string` | n/a | yes |
| <a name="input_kms_encryption_enabled"></a> [kms\_encryption\_enabled](#input\_kms\_encryption\_enabled) | Set this to true to control the encryption keys used to encrypt the data that you store in Data Engine. If set to false, the data is encrypted by using randomly generated keys. For more info on Key Protect integration, see https://cloud.ibm.com/docs/sql-query?topic=sql-query-securing-data. | `bool` | `false` | no |
| <a name="input_kms_endpoint"></a> [kms\_endpoint](#input\_kms\_endpoint) | The KMS endpoint to use when configuring KMS encryption. Must be private or public. | `string` | `"private"` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The root key ID of a Key Protect key that you want to use to encrypt your stored Data Engine jobs. Only used if var.kms\_encryption\_enabled is set to true. NOTE: Hyper Protect Crypto Services is not currently supported by Data Engine. | `string` | `null` | no |
| <a name="input_kms_region"></a> [kms\_region](#input\_kms\_region) | The region where KMS instance exists if using KMS encryption. | `string` | `"us-south"` | no |
| <a name="input_plan"></a> [plan](#input\_plan) | The plan for the Data Engine instance. Supported plans: standard or lite. | `string` | `"lite"` | no |
| <a name="input_region"></a> [region](#input\_region) | The region where you want to deploy your instance. | `string` | `"us-south"` | no |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | The resource group ID where the Data Engine instance will be created. | `string` | n/a | yes |
| <a name="input_skip_iam_authorization_policy"></a> [skip\_iam\_authorization\_policy](#input\_skip\_iam\_authorization\_policy) | Set to true to skip the creation of an IAM authorization policy that permits all Data Engine instances in the resource group to read the encryption key from the KMS instance. If set to false, pass in a value for the KMS instance in the existing\_kms\_instance\_guid variable. In addition, no policy is created if var.kms\_encryption\_enabled is set to false. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional, Array of Strings) A list of tags that you want to add to your instance. | `list(any)` | `[]` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_crn"></a> [crn](#output\_crn) | data engine crn |
| <a name="output_guid"></a> [guid](#output\_guid) | data engine guid |
| <a name="output_id"></a> [id](#output\_id) | data engine id |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- BEGIN CONTRIBUTING HOOK -->

<!-- Leave this section as is so that your module has a link to local development environment set up steps for contributors to follow -->

## Contributing

You can report issues and request features for this module in GitHub issues in the module repo. See [Report an issue or request a feature](https://github.com/terraform-ibm-modules/.github/blob/main/.github/SUPPORT.md).

To set up your local development environment, see [Local development setup](https://terraform-ibm-modules.github.io/documentation/#/local-dev-setup) in the project documentation.

<!-- Source for this readme file: https://github.com/terraform-ibm-modules/common-dev-assets/tree/main/module-assets/ci/module-template-automation -->
<!-- END CONTRIBUTING HOOK -->
