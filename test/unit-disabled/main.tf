module "test" {
  source = "../.."

  module_enabled = false

  # add all required arguments
  dataset_id = "unit-disabled"

  # add all optional arguments that create additional/extended resources
  friendly_name                   = "Unit Disable Test Dataset"
  description                     = "A test dataset created for testing purposes "
  project                         = local.project_id
  location                        = "europe-west3"
  default_table_expiration_ms     = 3600000
  default_partition_expiration_ms = 3600000
  labels = {
    Enironment = "Test"
  }
  # access                           = []
  # view                             = []
  # role                             = []
  # default_encryption_configuration = null
  # delete_contents_on_destroy       = true
  # authoritative                    = true
  # iam                              = []
}
