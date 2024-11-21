resource "google_bigquery_dataset" "dataset" {
  count = var.module_enabled ? 1 : 0

  depends_on = [var.module_depends_on]

  dataset_id                      = var.dataset_id
  default_table_expiration_ms     = var.default_table_expiration_ms
  default_partition_expiration_ms = var.default_partition_expiration_ms
  max_time_travel_hours           = var.max_time_travel_hours
  is_case_insensitive             = var.is_case_insensitive
  description                     = var.description
  friendly_name                   = var.friendly_name
  project                         = var.project
  location                        = var.location
  delete_contents_on_destroy      = var.delete_contents_on_destroy
  labels                          = var.labels
  resource_tags                   = var.resource_tags

  dynamic "access" {
    for_each = toset(var.access)

    content {
      role = try(access.value.role, null)

      domain         = try(access.value.domain, null)
      group_by_email = try(access.value.group_by_email, null)
      user_by_email  = try(access.value.user_by_email, null)
      special_group  = try(access.value.special_group, null)

      dynamic "view" {
        for_each = try(access.value.view, {})

        content {
          dataset_id = view.value.dataset_id
          project_id = view.value.project_id
          table_id   = view.value.table_id
        }
      }
    }
  }

  dynamic "default_encryption_configuration" {
    for_each = var.default_encryption_configuration == null ? [] : [var.default_encryption_configuration]

    content {
      kms_key_name = default_encryption_configuration.value.kms_key_name
    }
  }

  dynamic "external_dataset_reference" {
    for_each = var.external_dataset_reference == null ? [] : [var.external_dataset_reference]

    content {
      external_source = external_dataset_reference.value.external_source
      connection      = external_dataset_reference.value.connection
    }
  }

}
