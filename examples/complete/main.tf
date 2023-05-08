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
  source                    = "git::https://github.com/terraform-ibm-modules/terraform-ibm-key-protect-all-inclusive.git?ref=v3.1.2"
  resource_group_id         = module.resource_group.resource_group_id
  region                    = "us-south"
  key_protect_instance_name = "${var.prefix}-kp"
  resource_tags             = var.resource_tags
  key_map                   = { "icd" = ["${var.prefix}-data_engine"] }
  enable_metrics            = false
}


##############################################################################
# Data Engine
##############################################################################

locals {
  existing_kms_instance_guid = module.key_protect_all_inclusive.key_protect_guid
  kms_key_crn                = module.key_protect_all_inclusive.keys["icd.${var.prefix}-data_engine"].key_id
}

module "data_engine" {
  source                     = "../../"
  resource_group_id          = module.resource_group.resource_group_id
  key_protect_region         = "us-south"
  region                     = var.region
  plan                       = "standard"
  tags                       = var.resource_tags
  instance_name              = "${var.prefix}-data_engine"
  existing_kms_instance_guid = local.existing_kms_instance_guid
  kms_key_crn                = local.kms_key_crn
}

# Create IAM Access Policy to allow Key protect to access data engine instance
resource "ibm_iam_authorization_policy" "policy" {
  source_service_name         = "sql-query"
  source_resource_group_id    = module.resource_group.resource_group_id
  target_service_name         = "kms"
  target_resource_instance_id = local.existing_kms_instance_guid
  roles                       = ["Reader"]
}
