##############################################################################
# Outputs
##############################################################################
output "id" {
  description = "GUID of data engine instance"
  value       = module.data_engine.guid
}

output "name" {
  description = "Name of data engine instance"
  value       = module.data_engine.name
}
