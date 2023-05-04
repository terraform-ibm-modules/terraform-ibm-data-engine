variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API Key"
  sensitive   = true
}

variable "region" {
  type        = string
  description = "The region data engine is to be created on."
  default     = "us-south"
}

variable "prefix" {
  type        = string
  description = "Prefix to append to all resources created by this example"
  default     = "data_engine"
}

variable "resource_group" {
  type        = string
  description = "An existing resource group name to use for this example, if unset a new resource group will be created"
  default     = null
}

variable "resource_tags" {
  type        = list(string)
  description = "Optional list of tags to be added to created resources"
  default     = []
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
