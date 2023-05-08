
locals {
  # user managed encryption is only available with standard plan
  # existing_kms_instance_guid, kms_key_crn, key_protect_region would be ignored with lite plan, if provided
  # not providing either of existing_kms_instance_guid or kms_key_crn or key_protect_region, will disable user managed encryption
  enable_user_managed_encryption = var.plan == "standard" && var.existing_kms_instance_guid != null && var.kms_key_crn != null && var.key_protect_region != null

  kms_service = var.kms_key_crn != null ? (
    can(regex(".*kms.*", var.kms_key_crn)) ? "kms" : (
      can(regex(".*hs-crypto.*", var.kms_key_crn)) ? "hs-crypto" : "unrecognized key type"
    )
  ) : "no key crn"
}

resource "ibm_iam_authorization_policy" "kms_policy" {
  count                       = var.skip_iam_authorization_policy ? 0 : 1
  source_service_name         = "sql-query"
  source_resource_group_id    = var.resource_group_id
  target_service_name         = local.kms_service
  target_resource_instance_id = var.existing_kms_instance_guid
  roles                       = ["Reader"]
}

resource "ibm_resource_instance" "data_engine_instance" {
  name              = var.instance_name
  service           = "sql-query"
  plan              = var.plan
  location          = var.region
  resource_group_id = var.resource_group_id
  tags              = var.tags

  parameters = {
    customerKeyEncrypted : local.enable_user_managed_encryption
    kms_instance_id : jsonencode({
      "guid" = var.existing_kms_instance_guid
      "url"  = var.service_endpoints == "public" ? "https://${var.key_protect_region}.kms.cloud.ibm.com" : "https://private.${var.key_protect_region}.kms.cloud.ibm.com"
    }),
    kms_rootkey_id : var.kms_key_crn
  }
}
