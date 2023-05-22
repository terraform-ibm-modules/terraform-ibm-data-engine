##############################################################################
# Outputs
##############################################################################
output "id" {
  description = "ID of data engine instance"
  value       = module.data_engine.id
}

output "guid" {
  description = "GUID of data engine instance"
  value       = module.data_engine.guid
}

output "crn" {
  description = "crn of data engine instance"
  value       = module.data_engine.crn
}
