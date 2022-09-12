module "test" {
  source = "../.."

  # add all required arguments
  dataset_id = "unit-complete-${local.random_suffix}"

  # add all optional arguments that create additional/extended resources
  # iam                              = []

  # add most/all other optional arguments
  friendly_name                   = "Unit Complete Test Dataset"
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
}
