# Data Engine (SQL Query) Module

<!-- UPDATE BADGES:
1. Make sure that the badge link for the current status of the module is correct. For the status options, see https://github.ibm.com/GoldenEye/documentation/blob/master/status.md.
2. Update the "Build Status" badge to point to the travis pipeline for the module. Replace "module-template" in two places.
3. Update the "latest release" badge to point to the new module. Replace "module-template" in two places.
-->

[![Stable (With quality checks)](https://img.shields.io/badge/Status-Stable%20(With%20quality%20checks)-green)](https://terraform-ibm-modules.github.io/documentation/#/badge-status)
[![Build status](https://github.com/terraform-ibm-modules/terraform-ibm-data-engine/actions/workflows/ci.yml/badge.svg)](https://github.com/terraform-ibm-modules/terraform-ibm-data-engine/actions/workflows/ci.yml)
[![CI](https://img.shields.io/badge/CI-Toolchain%20Tekton%20Pipeline-3662FF?logo=ibm)](https://cloud.ibm.com/devops/toolchains/c3916535-165a-4275-9b1f-c58575839951?env_id=ibm:yp:us-south)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![latest release](https://img.shields.io/github/v/release/terraform-ibm-modules/terraform-ibm-data-engine?logo=GitHub&sort=semver)](https://github.com/terraform-ibm-modules/terraform-ibm-data-engine/releases/latest)

This module provisions data engine instance with key protect

## Usage

<!--
Add an example of the use of the module in the following code block.

Use real values instead of "var.<var_name>" or other placeholder values
unless real values don't help users know what to change.
-->

```hcl
# Replace "main" with a GIT release version to lock into a specific release
module "data_engine" {
  source               = "git::https://github.com/terraform-ibm-modules/terraform-ibm-data-engine.git?ref=main"
  resource_group_id    = "xxXXxxXXxXxXXXXxxXxxxXXXXxXXXXX"
  environment_name     = "data_engine"
  key_protect_region   = "us-south"
  region               = "us-south"
  plan                 = "lite"
}
```

<!--
Include the following 'Controls' section if the module implements NIST controls
Remove the 'section if the module does not implement controls
-->

<!-- GoldenEye core team only
## Compliance and security

This module implements the following NIST controls. For more information about how this module implements the controls in the following list, see [NIST controls](docs/controls.md).

| Profile | Category | ID       | Description |
|---------|----------|----------|-------------|
| NIST    | SC-7     | SC-7(3)  | Limit the number of external network connections to the information system. |

The 'Profile' and 'ID' columns are used by the IBM Cloud catalog to import
the controls into the catalog page.

In the example here, remove the SC-7 row and include a row for each control
that the module implements.

Include the control enhancement in the ID column ('SC-7(3)' in this example).

Identify how the module is complying with the controls. Summarize the
rationale or implementation in the 'Description' column.

For details about the controls, see the NIST Risk Management Framework page at
https://csrc.nist.gov/Projects/risk-management/sp800-53-controls/release-search#/controls?version=4.0.
-->

<!-- PERMISSIONS REQUIRED TO RUN MODULE
If this module requires permissions, uncomment the following block and update
the sample permissions, following the format.
Replace the sample Account and IBM Cloud service names and roles with the
information in the console at
Manage > Access (IAM) > Access groups > Access policies.
-->

## Required IAM access policies

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

<!-- NO PERMISSIONS FOR MODULE
If no permissions are required for the module, uncomment the following
statement instead the previous block.
-->

<!-- No permissions are needed to run this module.-->
<!-- END MODULE HOOK -->
<!-- BEGIN EXAMPLES HOOK -->
## Examples

- [ Complete Example With Standard Plan](examples/complete)
- [ Default Example With Lite Plan](examples/default)
<!-- END EXAMPLES HOOK -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.49.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ibm_iam_authorization_policy.kms_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/iam_authorization_policy) | resource |
| [ibm_resource_instance.data_engine_instance](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/resource_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_existing_kms_instance_guid"></a> [existing\_kms\_instance\_guid](#input\_existing\_kms\_instance\_guid) | The GUID of the Hyper Protect or Key Protect instance in which the key specified in var.kms\_key\_crn is coming from. Only required if skip\_iam\_authorization\_policy is false | `string` | `null` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name to of the new data engine instance | `string` | n/a | yes |
| <a name="input_key_protect_region"></a> [key\_protect\_region](#input\_key\_protect\_region) | (Optional) The region where key protect is deployed | `string` | `"us-south"` | no |
| <a name="input_kms_key_crn"></a> [kms\_key\_crn](#input\_kms\_key\_crn) | (Optional) The root key CRN of a Key Management Service like Key Protect or Hyper Protect Crypto Service (HPCS) that you want to use for disk encryption. If null, database is encrypted by using randomly generated keys. See https://cloud.ibm.com/docs/cloud-databases?topic=cloud-databases-key-protect&interface=ui#key-byok for current list of supported regions for BYOK | `string` | `null` | no |
| <a name="input_plan"></a> [plan](#input\_plan) | The plan for the Data engine instance. Standard or lite. | `string` | `"lite"` | no |
| <a name="input_region"></a> [region](#input\_region) | Name of the Region to deploy in data engine instance | `string` | `"us-south"` | no |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | ID of resource group to use when creating the data engine | `string` | n/a | yes |
| <a name="input_service_endpoints"></a> [service\_endpoints](#input\_service\_endpoints) | The type of the service endpoint that will be ...... | `string` | `"public"` | no |
| <a name="input_skip_iam_authorization_policy"></a> [skip\_iam\_authorization\_policy](#input\_skip\_iam\_authorization\_policy) | Set to true to skip the creation of an IAM authorization policy | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional, Array of Strings) A list of tags that you want to add to your instance. | `list(any)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_guid"></a> [guid](#output\_guid) | data engine guid |
| <a name="output_name"></a> [name](#output\_name) | data engine name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- BEGIN CONTRIBUTING HOOK -->

<!-- Leave this section as is so that your module has a link to local development environment set up steps for contributors to follow -->

## Contributing

You can report issues and request features for this module in the GoldenEye [issues](https://github.ibm.com/GoldenEye/issues) repo.See [Report a Bug or Create Enhancement Request](https://github.ibm.com/GoldenEye/documentation/blob/master/issues.md).

To set up your local development environment, see [Local development setup](https://github.ibm.com/GoldenEye/documentation/blob/master/local-dev-setup.md) in the project documentation.

<!-- Source for this readme file: https://github.com/terraform-ibm-modules/common-dev-assets/tree/main/module-assets/ci/module-template-automation -->
<!-- END CONTRIBUTING HOOK -->
