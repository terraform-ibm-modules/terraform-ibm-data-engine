locals {

  # Validation (approach based on https://github.com/hashicorp/terraform/issues/25609#issuecomment-1057614400)
  # tflint-ignore: terraform_unused_declarations
  validate_kms_values = !var.kms_encryption_enabled && var.kms_key_crn != null ? tobool("When passing values for var.kms_key_crn, you must set var.kms_encryption_enabled to true. Otherwise unset them to use default encryption") : true
  # tflint-ignore: terraform_unused_declarations
  validate_kms_vars = var.kms_encryption_enabled && var.kms_key_crn == null ? tobool("When setting var.kms_encryption_enabled to true, a value must be passed for var.kms_key_crn") : true
  # tflint-ignore: terraform_unused_declarations
  validate_auth_policy = var.kms_encryption_enabled && var.skip_iam_authorization_policy == false && var.existing_kms_instance_guid == null ? tobool("When var.skip_iam_authorization_policy is set to false, and var.kms_encryption_enabled to true, a value must be passed for var.existing_kms_instance_guid in order to create the auth policy.") : true
  # tflint-ignore: terraform_unused_declarations
  byok_encryption_pan = var.plan == "lite" && var.kms_encryption_enabled ? tobool("User-managed key encryption is only available for the Standard plan.") : true
}

resource "ibm_iam_authorization_policy" "kms_policy" {
  count                       = var.kms_encryption_enabled == false || var.skip_iam_authorization_policy ? 0 : 1
  source_service_name         = "sql-query"
  source_resource_group_id    = var.resource_group_id
  target_service_name         = "kms"
  target_resource_instance_id = var.existing_kms_instance_guid
  roles                       = ["Reader"]
}

# workaround for https://github.com/IBM-Cloud/terraform-provider-ibm/issues/4478
resource "time_sleep" "wait_for_authorization_policy" {
  depends_on = [ibm_iam_authorization_policy.kms_policy]

  create_duration = "30s"
}

resource "ibm_resource_instance" "data_engine_instance" {
  name              = var.instance_name
  service           = "sql-query"
  plan              = var.plan
  location          = var.region
  resource_group_id = var.resource_group_id
  tags              = var.tags

  parameters = {
    customerKeyEncrypted : var.kms_encryption_enabled
    kms_instance_id : jsonencode({
      "guid" = var.existing_kms_instance_guid
      "url"  = var.service_endpoints == "public" ? "https://${var.kms_region}.kms.cloud.ibm.com" : "https://private.${var.kms_region}.kms.cloud.ibm.com"
    }),
    kms_rootkey_id : var.kms_key_crn
  }
}
