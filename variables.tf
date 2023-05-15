##############################################################################
# Input Variables
##############################################################################


variable "resource_group_id" {
  description = "ID of resource group to use when creating the data engine"
  type        = string
}


variable "instance_name" {
  description = "Name to of the new data engine instance"
  type        = string
}

variable "tags" {
  type        = list(any)
  description = "(Optional, Array of Strings) A list of tags that you want to add to your instance."
  default     = []
}


variable "region" {
  type        = string
  description = "Name of the Region to deploy in data engine instance"
  default     = "us-south"
}

variable "plan" {
  type        = string
  description = "The plan for the Data engine instance. Standard or lite."
  default     = "lite"

  validation {
    condition     = contains(["standard", "lite"], var.plan)
    error_message = "Supported plans: standard or lite."
  }
}

variable "service_endpoints" {
  description = "The type of the service endpoint for the data engine."
  type        = string
  default     = "private"
  validation {
    condition     = contains(["public", "private", "public-and-private"], var.service_endpoints)
    error_message = "The endpoint value must be one of the following: public , private and public-and-private"
  }
}

variable "kms_encryption_enabled" {
  type        = bool
  description = "Set this to true to control the encryption keys used to encrypt the data that you store in IBM Cloud® Databases. If set to false, the data is encrypted by using randomly generated keys. For more info on Key Protect integration, see https://cloud.ibm.com/docs/cloud-databases?topic=cloud-databases-key-protect. For more info on HPCS integration, see https://cloud.ibm.com/docs/cloud-databases?topic=cloud-databases-hpcs"
  default     = false
}

variable "skip_iam_authorization_policy" {
  type        = bool
  description = "Set to true to skip the creation of an IAM authorization policy that permits all Data Engine instances in the given resource group to read the encryption key from the KMS instance provided in 'existing_kms_instance_guid'"
  default     = true
}

variable "kms_region" {
  description = "(Optional) The region where key protect is deployed"
  type        = string
  default     = "us-south"
}

variable "existing_kms_instance_guid" {
  type        = string
  description = "The GUID of the Key Protect instance in which the key specified in var.kms_key_crn is coming from."
  default     = null
}

variable "kms_key_crn" {
  type        = string
  description = "The root key CRN of a Key Management Service like Key Protect that you want to use for disk encryption. If null, database is encrypted by using randomly generated keys. See https://cloud.ibm.com/docs/sql-query?topic=sql-query-keyprotect"
  default     = null
}
