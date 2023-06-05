module "data_engine" {
  source                        = "../../"
  instance_name                 = var.instance_name
  resource_group_id             = var.resource_group_id
  skip_iam_authorization_policy = var.skip_iam_authorization_policy
  tags                          = var.tags
  plan                          = "standard"
  kms_encryption_enabled        = true
  existing_kms_instance_guid    = var.existing_kms_instance_guid
  kms_key_crn                   = var.kms_key_crn
  # allowlist                     = var.allowlist
}
