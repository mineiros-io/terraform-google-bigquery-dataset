module "test" {
  source = "../.."

  # add all required arguments
  dataset_id                      = "unit-complete-${local.random_suffix}"
  friendly_name                   = "friendly_name"
  description                     = "description"
  project                         = local.project_id
  location                        = "europe-west1"
  default_partition_expiration_ms = 3600000
  default_table_expiration_ms     = 3600000

  labels = {
    env = "default"
  }

  access = [
    {
      role           = "roles/browser"
      domain         = "example.com"
      group_by_email = "group@example.com"
      user_by_email  = "user@example.com"
      special_group  = "projectOwners"
    }
  ]

  view = [
    {
      project_id = local.project_id
      table_id   = "table_id"
      dataset_id = "dataset_id"
    }
  ]

  role = [
    {
      role           = "roles/browser"
      special_group  = "projectOwners"
      group_by_email = "group@example.com"
      user_by_email  = "user@example.com"
    }
  ]

  iam = [
    {
      role    = "roles/browser"
      members = ["domain:example.com"]
    },
    {
      role    = "roles/editor"
      members = ["domain:example.com"]
      condition = {
        title       = "deny after 2025"
        description = "allow access until 2025"
        expression  = "request.time.getFullYear() < 2025"
      }
    },
    {
      role    = "roles/viewer"
      members = ["domain:example.com"]
      condition = {
        title       = "allow after 2020"
        description = "allow access from 2020"
        expression  = "request.time.getFullYear() > 2020"
      }
    }
  ]

  default_encryption_configuration = {
    kms_key_name = "kms_name"
  }

  delete_contents_on_destroy = true
  authoritative              = true
}
