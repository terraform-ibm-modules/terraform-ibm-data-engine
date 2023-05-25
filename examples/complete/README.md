# Complete example with BYOK encryption and CBR rules

An end-to-end example that uses the IBM Cloud Terraform provider to create the following infrastructure:

- A resource group, if one is not passed in.
- A Key Protect instance with a root key.
- An instance of IBM Cloud® Data Engine with BYOK encryption.
- A context-based restriction (CBR) rule to only allow Data Engine to be accessible from within the VPC.
