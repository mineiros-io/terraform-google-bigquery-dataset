[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>][homepage]

[![Terraform Version][badge-terraform]][releases-terraform]
[![Google Provider Version][badge-tf-gcp]][releases-google-provider]
[![Join Slack][badge-slack]][slack]

# terraform-google-bigquery-dataset

A [Terraform](https://www.terraform.io) module to create a [Google Bigquery Dataset](https://cloud.google.com/bigquery/docs/datasets-intro) on [Google Cloud Services (GCP)](https://cloud.google.com/).

**_This module supports Terraform version 1
and is compatible with the Terraform Google Provider version 3._**

This module is part of our Infrastructure as Code (IaC) framework
that enables our users and customers to easily deploy and manage reusable,
secure, and production-grade cloud infrastructure.

- [terraform-google-bigquery-dataset](#terraform-google-bigquery-dataset)
  - [Module Features](#module-features)
  - [Getting Started](#getting-started)
  - [Module Argument Reference](#module-argument-reference)
    - [Top-level Arguments](#top-level-arguments)
      - [Module Configuration](#module-configuration)
      - [Main Resource Configuration](#main-resource-configuration)
      - [Extended Resource Configuration](#extended-resource-configuration)
  - [Module Attributes Reference](#module-attributes-reference)
  - [External Documentation](#external-documentation)
    - [Google Documentation:](#google-documentation)
    - [Terraform Google Provider Documentation:](#terraform-google-provider-documentation)
  - [Module Versioning](#module-versioning)
    - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
  - [About Mineiros](#about-mineiros)
  - [Reporting Issues](#reporting-issues)
  - [Contributing](#contributing)
  - [Makefile Targets](#makefile-targets)
  - [License](#license)

## Module Features

A [Terraform] base module for creating a `google_bigquery_dataset` resources. Datasets are top-level containers that are used to organize and control access to your tables and views.

## Getting Started

Most basic usage just setting required arguments:

```hcl
module "terraform-google-bigquery-dataset" {
  source = "github.com/mineiros-io/terraform-google-bigquery-dataset.git?ref=v0.1.0"

  dataset_id = "example_dataset"
}
```

## Module Argument Reference

See [variables.tf] and [examples/] for details and use-cases.

### Top-level Arguments

#### Module Configuration

- **`module_enabled`**: _(Optional `bool`)_

  Specifies whether resources in the module will be created.

  Default is `true`.

- **`module_depends_on`**: _(Optional `list(dependencies)`)_

  A list of dependencies. Any object can be _assigned_ to this list to define a hidden external dependency.

  Example:
  ```hcl
  module_depends_on = [
    google_network.network
  ]
  ```

#### Main Resource Configuration

- **`dataset_id`**: **_(Required `string`)_**

  A unique ID for this dataset, without the project name.

- **`friendly_name`**: _(Optional `string`)_

  A descriptive name for the dataset.

- **`description`**: _(Optional `string`)_

  A user-friendly description of the dataset.

- **`project`**: _(Optional `string`)_

  The ID of the project in which the resource belongs.
  Default is the project that is configured in the provider.

- **`location`**: _(Optional `string`)_

  The geographic location where the dataset should reside.

- **`default_table_expiration_ms`**: _(Optional `number`)_

  The default lifetime of all tables in the dataset, in milliseconds.
  Once this property is set, all newly-created partitioned tables in the dataset will have an `expirationMs` property in the `timePartitioning` settings set to this value, and changing the value will only affect new tables, not existing ones. The storage in a partition will have an expiration time of its partition time plus this value. Setting this property overrides the use of `defaultTableExpirationMs` for partitioned tables: only one of `defaultTableExpirationMs` and `defaultPartitionExpirationMs` will be used for any new partitioned table. If you provide an explicit `timePartitioning.expirationMs` when creating or updating a partitioned table, that value takes precedence over the default partition expiration time indicated by this property.

- **`default_partition_expiration_ms`**: _(Optional `number`)_

  The default partition expiration for all partitioned tables in the dataset, in milliseconds.The minimum value is `3600000` milliseconds (one hour).

- **`labels`**: _(Optional `map(string)`)_

  Key value pairs in a map for dataset lab.

  Default is `{}`.

- **`access`**: _(Optional `list(access)`)_

  An array of objects that define dataset access for one or more entities.

  Default is `[]`.

  An `access` object can have the following fields:

  - **`domain`**: _(Optional `string`)_

    A domain to grant access to. Any users signed in with the domain specified will be granted the specified access.

  - **`role`**: _(Optional `string`)_

    Describes the rights granted to the user specified by the other member of the access object. Basic, predefined, and custom roles are supported. Predefined roles that have equivalent basic roles are swapped by the API to their basic counterparts.

  - **`group_by_email`**: _(Optional `string`)_

    An email address of a Google Group to grant access to.

  - **`user_by_email`**: _(Optional `string`)_

    An email address of a Google User to grant access to.

  - **`special_group`**: _(Optional `string`)_

    A special group to grant access to. Possible values include:
    - `projectOwners`: Owners of the enclosing project.
    - `projectReaders`: Readers of the enclosing project.
    - `projectWriters`: Writers of the enclosing project.
    - `allAuthenticatedUsers`: All authenticated BigQuery users.

- **`view`**: _(Optional `object(view)`)_

  A view from a different dataset to grant access to.

  Default is `true`.

  A `view` object can have the following fields:

  - **`project_id`**: **_(Required `string`)_**

    The ID of the project containing this table.

  - **`table_id`**: **_(Required `string`)_**

    The ID of the dataset containing this table.

  - **`dataset_id`**: **_(Required `string`)_**

    The ID of the table.

- **`default_encryption_configuration`**: _(Optional `object(default_encryption_configuration)`)_

  The default encryption key for all tables in the dataset. Once this property is set, all newly-created partitioned tables in the dataset will have encryption key set to this value, unless table creation request (or query) overrides the key.

  A `default_encryption_configuration` object can have the following fields:

  - **`kms_key_name`**: **_(Required `string`)_**

    Describes the Cloud KMS encryption key that will be used to protect destination BigQuery table.
    The BigQuery Service Account associated with your project requires access to this encryption key.

- **`delete_contents_on_destroy`**: _(Optional `bool`)_

  If set to true, delete all the tables in the dataset when destroying the resource; otherwise, destroying the resource will fail if tables are present.

  Default is `false`.

- **`iam`**: _(Optional `list(iam)`)_

  A list of IAM access to apply to the created secret.

  Default is `[]`.

  Each `iam` object can have the following fields:

  - **`role`**: **_(Required `string`)_**

    The role that should be applied. Note that custom roles must be of the format [projects|organizations]/{parent-name}/roles/{role-name}.

  - **`members`**: _(Optional `set(string)`)_

    Identities that will be granted the privilege in role. Each entry can have one of the following values:
    - `allUsers`: A special identifier that represents anyone who is on the internet; with or without a Google account.
    - `allAuthenticatedUsers`: A special identifier that represents anyone who is authenticated with a Google account or a service account.
    - `user:{emailid}`: An email address that represents a specific Google account. For example, `alice@gmail.com` or `joe@example.com`.
    - `serviceAccount:{emailid}`: An email address that represents a service account. For example, `my-other-app@appspot.gserviceaccount.com`.
    - `group:{emailid}`: An email address that represents a Google group. For example, `admins@example.com`.
    - `domain:{domain}`: A G Suite domain (primary, instead of alias) name that represents all the users of that domain. For example, `google.com` or `example.com`.

    Default is `[]`.

  - **`authoritative`**: _(Optional `bool`)_

    Whether to exclusively set (authoritative mode) or add (non-authoritative/additive mode) members to the role.

    Default is `true`.

#### Extended Resource Configuration

## Module Attributes Reference

The following attributes are exported in the outputs of the module:

- **`module_enabled`**

  Whether this module is enabled.

- **`google_bigquery_dataset`**

  A map of outputs of the created google_project_iam_member resources keyed by role.

- **`iam`**

  The iam resource objects that define the access to the secret.

## External Documentation

### Google Documentation:

- Bigquery Dataset: <https://cloud.google.com/bigquery/docs/datasets-intro>
- Bigquery Access Control: <https://cloud.google.com/bigquery/docs/access-control>

### Terraform Google Provider Documentation:

- <https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset>
- <https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset_iam>

## Module Versioning

This Module follows the principles of [Semantic Versioning (SemVer)].

Given a version number `MAJOR.MINOR.PATCH`, we increment the:

1. `MAJOR` version when we make incompatible changes,
2. `MINOR` version when we add functionality in a backwards compatible manner, and
3. `PATCH` version when we make backwards compatible bug fixes.

### Backwards compatibility in `0.0.z` and `0.y.z` version

- Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
- Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)

## About Mineiros

[Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
that solves development, automation and security challenges in cloud infrastructure.

Our vision is to massively reduce time and overhead for teams to manage and
deploy production-grade and secure cloud infrastructure.

We offer commercial support for all of our modules and encourage you to reach out
if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
[Community Slack channel][slack].

## Reporting Issues

We use GitHub [Issues] to track community reported issues and missing features.

## Contributing

Contributions are always encouraged and welcome! For the process of accepting changes, we use
[Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].

## Makefile Targets

This repository comes with a handy [Makefile].
Run `make help` to see details on each available target.

## License

[![license][badge-license]][apache20]

This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE] for full details.

Copyright &copy; 2020-2021 [Mineiros GmbH][homepage]


<!-- References -->

[homepage]: https://mineiros.io/?ref=terraform-google-bigquery-dataset
[hello@mineiros.io]: mailto:hello@mineiros.io

<!-- markdown-link-check-disable -->

[badge-build]: https://github.com/mineiros-io/terraform-google-bigquery-dataset/workflows/Tests/badge.svg

<!-- markdown-link-check-enable -->

[badge-semver]: https://img.shields.io/github/v/tag/mineiros-io/terraform-google-bigquery-dataset.svg?label=latest&sort=semver
[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[badge-terraform]: https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform
[badge-slack]: https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack

<!-- markdown-link-check-disable -->

[build-status]: https://github.com/mineiros-io/terraform-google-bigquery-dataset/actions
[releases-github]: https://github.com/mineiros-io/terraform-google-bigquery-dataset/releases

<!-- markdown-link-check-enable -->

[releases-terraform]: https://github.com/hashicorp/terraform/releases
[badge-tf-gcp]: https://img.shields.io/badge/google-3.x-1A73E8.svg?logo=terraform
[releases-google-provider]: https://github.com/terraform-providers/terraform-provider-google/releases
[apache20]: https://opensource.org/licenses/Apache-2.0
[slack]: https://mineiros.io/slack
[terraform]: https://www.terraform.io
[gcp]: https://cloud.google.com/
[semantic versioning (semver)]: https://semver.org/

<!-- markdown-link-check-disable -->

[variables.tf]: https://github.com/mineiros-io/terraform-google-bigquery-dataset/blob//main/variables.tf
[examples/]: https://github.com/mineiros-io/terraform-google-bigquery-dataset/blob/main/examples
[issues]: https://github.com/mineiros-io/terraform-google-bigquery-dataset/issues
[license]: https://github.com/mineiros-io/terraform-google-bigquery-dataset/blob/main/LICENSE
[makefile]: https://github.com/mineiros-io/terraform-google-bigquery-dataset/blob/main/Makefile
[pull requests]: https://github.com/mineiros-io/terraform-google-bigquery-dataset/pulls
[contribution guidelines]: https://github.com/mineiros-io/terraform-google-bigquery-dataset/blob/main/CONTRIBUTING.md

<!-- markdown-link-check-enable -->
