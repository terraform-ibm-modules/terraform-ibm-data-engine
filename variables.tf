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

variable "key_protect_region" {
  description = "(Optional) The region where key protect is deployed"
  type        = string
  default     = "us-south"
}

variable "key_protect_guid" {
  type        = string
  description = "(Optional) Guid of existing key protect to be used"
  default     = null
}

variable "key_protect_root_key" {
  type        = string
  description = "(Optional) Id of existing key to be used"
  default     = null
}
