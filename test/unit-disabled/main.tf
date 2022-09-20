module "test" {
  source = "../.."

  module_enabled = false

  # add all required arguments

  dataset_id = "unit-disabled-${local.random_suffix}"

  # add all optional arguments that create additional/extended resources
}
