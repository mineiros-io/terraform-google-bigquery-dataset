locals {
  iam_map = { for iam in var.iam : iam.role => iam }
}

module "iam" {
  source = "./modules/terraform-google-bigquery-dataset-iam"

  for_each = local.iam_map

  module_enabled    = var.module_enabled
  module_depends_on = var.module_depends_on

  dataset_id    = google_bigquery_dataset.dataset[0].dataset_id
  role          = each.value.role
  members       = each.value.members
  authoritative = try(each.value.authoritative, true)
}
