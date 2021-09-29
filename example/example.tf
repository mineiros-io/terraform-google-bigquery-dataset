module "dataset" {
  source = "../"

  dataset_id                  = "example_dataset"
  friendly_name               = "example_name"
  description                 = "This is a test description"
  location                    = "EU"
  default_table_expiration_ms = 3600000
  authoritative               = true


  access = [
    {
      role          = "OWNER"
      user_by_email = "example@goflink.com"

      view = [
        {
          dataset_id = "example-dataset-id"
          project_id = "flink-platform-dev"
          table_id   = "test-table-id"
        }
      ]
    }
  ]

  default_encryption_configuration = {
    kms_key_name = google_kms_crypto_key.crypto_key.id
  }
}

resource "google_kms_crypto_key" "crypto_key" {
  name     = "example-key"
  key_ring = google_kms_key_ring.key_ring.id
}

resource "google_kms_key_ring" "key_ring" {
  name     = "example-keyring"
  location = "EU"
}
