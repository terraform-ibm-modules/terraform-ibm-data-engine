
locals {
  # user managed encryption is only available with standard plan
  # key_protect_guid, key_protect_root_key, key_protect_region would be ignored with lite plan, if provided
  # not providing either of key_protect_guid or key_protect_root_key or key_protect_region, will disable user managed encryption
  enable_user_managed_encryption = var.plan == "standard" && var.key_protect_guid != null && var.key_protect_root_key != null && var.key_protect_region != null
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
      "guid" = var.key_protect_guid
      "url"  = "https://${var.key_protect_region}.kms.cloud.ibm.com"
    }),
    kms_rootkey_id : var.key_protect_root_key
  }
}