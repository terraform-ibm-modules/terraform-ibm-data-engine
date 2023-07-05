variable "prefix" {
  type        = string
  description = "Prefix to append to all resources created by this example"
  default     = "data-engine"
}

variable "resource_group_id" {
  description = "ID of resource group to use when creating the event stream instance"
  type        = string
}

variable "tags" {
  type        = list(string)
  description = "List of tags associated with the Event Steams instance"
  default     = []
}

variable "instance_name" {
  description = "Name of the data engine instance"
  type        = string
}

variable "allowlist" {
  type = list(object({
    address     = optional(string)
    description = optional(string)
  }))
  default     = []
  description = "Set of IP address and description to allowlist in database"
}

variable "existing_kms_instance_guid" {
  type        = string
  description = "The GUID the Key Protect instance"
  }

variable "kms_key_crn" {
  type        = string
  description = "The root key CRN of a Key Protect key that you want to use for disk encryption"
}

variable "skip_iam_authorization_policy" {
  type        = bool
  description = "Set to true to skip the creation of an IAM authorization policy that permits all event streams instances in the provided resource group reader access to the instance specified in the existing_kms_instance_guid variable."
  default     = false
}
