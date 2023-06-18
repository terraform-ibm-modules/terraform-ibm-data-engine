##############################################################################
# Resource Group
##############################################################################

module "resource_group" {
  source = "git::https://github.com/terraform-ibm-modules/terraform-ibm-resource-group.git?ref=v1.0.5"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

##############################################################################
# Key Protect All Inclusive
##############################################################################

module "key_protect_all_inclusive" {
  source                    = "git::https://github.com/terraform-ibm-modules/terraform-ibm-key-protect-all-inclusive.git?ref=v4.2.0"
  resource_group_id         = module.resource_group.resource_group_id
  region                    = var.region
  key_protect_instance_name = "${var.prefix}-kp"
  resource_tags             = var.resource_tags
  key_map                   = { "sql" = ["${var.prefix}-data-engine"] }
}

##############################################################################
# Data Engine
##############################################################################

module "data_engine" {
  source                     = "../../"
  resource_group_id          = module.resource_group.resource_group_id
  kms_region                 = var.region
  region                     = var.region
  tags                       = var.resource_tags
  instance_name              = "${var.prefix}-data_engine"
  plan                       = "standard"
  kms_encryption_enabled     = true
  existing_kms_instance_guid = module.key_protect_all_inclusive.key_protect_guid
  kms_key_crn                = module.key_protect_all_inclusive.keys["sql.${var.prefix}-data-engine"].crn
}
