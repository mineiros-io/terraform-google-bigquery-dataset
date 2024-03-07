locals {
  iam_map = { for iam in var.iam : iam.role => iam }
}

module "iam" {
  source = "github.com/mineiros-io/terraform-google-bigquery-dataset-iam?ref=v0.1.0"

  for_each = local.iam_map

  module_enabled    = var.module_enabled
  module_depends_on = var.module_depends_on

  dataset_id    = google_bigquery_dataset.dataset[0].dataset_id
  role          = each.value.role
  members       = each.value.members
  authoritative = try(each.value.authoritative, true)
}
