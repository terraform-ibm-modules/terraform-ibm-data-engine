terraform {
  required_version = ">= 1.0.0, <1.6.0"
  # Use "greater than or equal to" range in modules
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.49.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.9.1"
    }
  }
}
