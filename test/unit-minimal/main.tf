module "test" {
  source = "../.."

  # add only required arguments and no optional arguments

  dataset_id = "unit-minimal-${local.random_suffix}"
}
