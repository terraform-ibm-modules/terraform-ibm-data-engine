##############################################################################
# Input Variables
##############################################################################

variable "resource_group_id" {
  description = "The resource group ID where the Data Engine instance will be created."
  type        = string
}

variable "instance_name" {
  description = "The name to give the Data Engine instance."
  type        = string
}

variable "tags" {
  type        = list(any)
  description = "(Optional, Array of Strings) A list of tags that you want to add to your instance."
  default     = []
}

variable "region" {
  type        = string
  description = "The region where you want to deploy your instance."
  default     = "us-south"
}

variable "plan" {
  type        = string
  description = "The plan for the Data Engine instance. Supported plans: standard or lite."
  default     = "lite"

  validation {
    condition     = contains(["standard", "lite"], var.plan)
    error_message = "Supported plans: standard or lite."
  }
}

variable "kms_endpoint" {
  description = "The KMS endpoint to use when configuring KMS encryption. Must be private or public."
  type        = string
  default     = "private"
  validation {
    condition     = contains(["public", "private"], var.kms_endpoint)
    error_message = "Valid values for service_endpoints are 'public' or 'private'."
  }
}

variable "kms_encryption_enabled" {
  type        = bool
  description = "Set this to true to control the encryption keys used to encrypt the data that you store in Data Engine. If set to false, the data is encrypted by using randomly generated keys. For more info on Key Protect integration, see https://cloud.ibm.com/docs/sql-query?topic=sql-query-securing-data."
  default     = false
}

variable "skip_iam_authorization_policy" {
  type        = bool
  description = "Set to true to skip the creation of an IAM authorization policy that permits all Data Engine instances in the resource group to read the encryption key from the KMS instance. If set to false, pass in a value for the KMS instance in the existing_kms_instance_guid variable. In addition, no policy is created if var.kms_encryption_enabled is set to false."
  default     = false
}

variable "kms_region" {
  description = "The region where KMS instance exists if using KMS encryption."
  type        = string
  default     = "us-south"
}

variable "existing_kms_instance_guid" {
  type        = string
  description = "The GUID the Key Protect instance in which the key specified in var.kms_key_crn is coming from. Required only if var.kms_encryption_enabled is set to true, var.skip_iam_authorization_policy is set to false. NOTE: Hyper Protect Crypto Services is not currently supported by Data Engine."
  default     = null
}

variable "kms_key_id" {
  type        = string
  description = "The root key ID of a Key Protect key that you want to use to encrypt your stored Data Engine jobs. Only used if var.kms_encryption_enabled is set to true. NOTE: Hyper Protect Crypto Services is not currently supported by Data Engine."
  default     = null
  validation {
    condition = anytrue([
      var.kms_key_id == null,
      can(regex(".*kms.*", var.kms_key_id)),
    ])
    error_message = "Value must be the root key id from Key Protect"
  }
}
