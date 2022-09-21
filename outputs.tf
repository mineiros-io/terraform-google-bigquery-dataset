# ------------------------------------------------------------------------------
# OUTPUT CALCULATED VARIABLES (prefer full objects)
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OUTPUT ALL RESOURCES AS FULL OBJECTS
# ------------------------------------------------------------------------------

output "google_bigquery_dataset" {
  description = "The google_bigquery_dataset resource object created by this module."
  value       = try(google_bigquery_dataset.dataset[0], {})
}

# remap iam to reduce one level of access (iam[]. instead of iam[].iam.)
output "iam" {
  description = "The resources created by `mineiros-io/bigquery-dataset-iam/google` module."
  value       = { for key, iam in module.iam : key => iam.iam }
}

# ------------------------------------------------------------------------------
# OUTPUT ALL INPUT VARIABLES
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OUTPUT MODULE CONFIGURATION
# ------------------------------------------------------------------------------
