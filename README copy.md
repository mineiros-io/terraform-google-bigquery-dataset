[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>][homepage]

[![Terraform Version][badge-terraform]][releases-terraform]
[![Google Provider Version][badge-tf-gcp]][releases-google-provider]
[![Join Slack][badge-slack]][slack]

# terraform-google-bigquery-dataset

A [Terraform] module for [Google Cloud Platform (GCP)][gcp].

**_This module supports Terraform version 1
and is compatible with the Terraform Google Provider version 3._**

This module is part of our Infrastructure as Code (IaC) framework
that enables our users and customers to easily deploy and manage reusable,
secure, and production-grade cloud infrastructure.

- [Module Features](#module-features)
- [Getting Started](#getting-started)
- [Module Argument Reference](#module-argument-reference)
  - [Top-level Arguments](#top-level-arguments)
    - [Module Configuration](#module-configuration)
    - [Main Resource Configuration](#main-resource-configuration)
    - [Extended Resource Configuration](#extended-resource-configuration)
      - [terraform-google-bigquery-dataset-iam](#terraform-google-bigquery-dataset-iam)
- [Module Attributes Reference](#module-attributes-reference)
- [External Documentation](#external-documentation)
- [Module Versioning](#module-versioning)
  - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Makefile Targets](#makefile-targets)
- [License](#license)

## Module Features

In contrast to the plain `terraform_google_bigquery_dataset` resource this module has better features.
While all security features can be disabled as needed best practices
are pre-configured.

<!--
These are some of our custom features:

- **Default Security Settings**:
  secure by default by setting security to `true`, additional security can be added by setting some feature to `enabled`

- **Standard Module Features**:
  Cool Feature of the main resource, tags

- **Extended Module Features**:
  Awesome Extended Feature of an additional related resource,
  and another Cool Feature

- **Additional Features**:
  a Cool Feature that is not actually a resource but a cool set up from us

- _Features not yet implemented_:
  Standard Features missing,
  Extended Features planned,
  Additional Features planned
-->

## Getting Started

Most basic usage just setting required arguments:

```hcl
module "terraform-google-bigquery-dataset" {
  source = "git@github.com:mineiros-io/terraform-google-premium-modules.git/modules//terraform-google-bigquery-dataset?ref=v1"
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

  A unique ID for this dataset, without the project name. The ID must contain only letters `(a-z, A-Z)`, numbers `(0-9)`, or underscores `(_)`. The maximum length is `,024 characters.

- **`friendly_name`**: _(Optional `string`)_

  Friendly name for the dataset being provisioned."
  Default is `null`.

- **`description`**: _(Optional `string`)_

  A user-friendly description of the dataset.
  Default is `null`.

- **`project`**: _(Optional `string`)_

  The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  Default is `null`.

- **`location`**: _(Optional `string`)_

  The geographic location where the dataset should reside.
  Default is `null`.

- **`default_table_expiration_ms`**: _(Optional `number`)_

  The default lifetime of all tables in the dataset, in milliseconds.
  Default is `null`.

- **`default_partition_expiration_ms`**: _(Optional `number`)_

  The default partition expiration for all partitioned tables in the dataset, in milliseconds.
  Default is `null`.

- **`labels`**: _(Optional `map(string)`)_

  Key value pairs in a map for dataset labels.
  Default is `{}`.

- **`access`**: _(Optional `list(access)`)_

  An array of objects that define dataset access for one or more entities.
  Default is `[]`.

  An `access` object can have the following fields:

  - **`domain`**: _(Optional `string`)_

    A domain to grant access to. Any users signed in with the domain specified will be granted the specified access.
    Default is `null`.

  - **`role`**: _(Optional `string`)_

    Describes the rights granted to the user specified by the other member of the access object. Basic, predefined, and custom roles are supported.
    Default is `null`.

  - **`group_by_email`**: _(Optional `string`)_

    An email address of a Google Group to grant access to.
    Default is `null`.

  - **`user_by_email`**: _(Optional `string`)_

    An email address of a Google Group to grant access to.
    Default is `null`.

  - **`special_group`**: _(Optional `string`)_

    A special group to grant access to. Possible values include:
    projectOwners: Owners of the enclosing project.
    ProjectReaders: Readers of the enclosing project.
    projectWriters: Writers of the enclosing project.
    allAuthenticatedUsers: All authenticated BigQuery users.
    Default is `null`.

- **`view`**: _(Optional `object(view)`)_

  A view from a different dataset to grant access to."
  Default is `true`.

  A `view` object can have the following fields:

  - **`project_id`**: **_(Required `string`)_**

    The ID of the project containing this table.

  - **`table_id`**: **_(Required `string`)_**

    The ID of the dataset containing this table.

  - **`dataset_id`**: **_(Required `string`)_**

    The ID of the table. The ID must contain only letters `(a-z, A-Z)`, numbers `(0-9)`, or underscores `(_)`.

- **`default_encryption_configuration`**: _(Optional `object(default_encryption_configuration)`)_

  The default encryption key for all tables in the dataset. Once this property is set, all newly-created partitioned tables in the dataset will have encryption key set to this value, unless table creation request (or query) overrides the key.
  Default is `null`.

  A `default_encryption_configuration` object can have the following fields:

  - **`kms_key_name`**: **_(Required `string`)_**

    Describes the Cloud KMS encryption key that will be used to protect destination BigQuery table.
    The BigQuery Service Account associated with your project requires access to this encryption key.

- **`delete_contents_on_destroy`**: _(Optional `bool`)_

  If set to true, delete all the tables in the dataset when destroying the resource; otherwise, destroying the resource will fail if tables are present.
  Default is `false`.

- **`authoritative`**: _(Optional `bool`)_

  google bigquery dataset iam choice whether `'authoritative == true'` use `google_bigquery_iam_binding`, `'authoritative == false'` `use google_bigquery_iam_member`
  Default is `true`.

- **`iam`**: _(Optional `list(iam)`)_

  A list of IAM access to apply to the created secret.
  Default is `[]`.

<!-- Example of a required variable:

- **`name`**: **_(Required `string`)_**

  The name of the resource.
  Default is `true`.

-->

<!-- Example of an optional variable:

- **`name`**: _(Optional `string`)_

  The name of the resource.
  Default is `true`.

-->

<!-- Example of an object:
     - We use inline documentation to describe complex objects or lists/maps of complex objects.
     - Please indent each level with 2 spaces so the documentation is rendered in a readable way.

- **`user`**: _(Optional `object(user)`)_

  A user object.
  Default is `true`.

  A/Each `user` object can have the following fields:

  - **`name`**: **_(Required `string`)_**

    The Name of the user.

  - **`description`**: _(Optional `decription`)_

    A description describing the user in more detail.
    Default is "".

  Example
  ```hcl
  user = {
    name        = "marius"
    description = "The guy from Berlin."
  }
  ```
-->

#### Extended Resource Configuration

##### terraform-google-bigquery-dataset-iam

 **`dataset_id`**: **_(Required `string`)_**

  A unique ID for this dataset, without the project name. The ID must contain only letters `(a-z, A-Z)`, numbers `(0-9)`, or underscores `(_)`. The maximum length is 1,024 characters.

- **`role`**: **_(Required `string`)_**

  The role that should be applied. Only one `'google_secret_manager_secret_iam_binding'` can be used per role. Note that custom roles must be of the format `'[projects|organizations]/{parent-name}/roles/{role-name}'`.

- **`projects`**: _(Optional `string`)_

  The ID of the project in which the resource belongs. If it is not provided, the provider project is used.
  Default is `null`.

- **`members`**: _(Optional `set(string)`)_

  Identities that will be added/set to/for the role. Each entry can have one of the following values: `'allUsers'`, `'allAuthenticatedUsers'`, `'serviceAccount:{emailid}'`, `'group:{emailid}'`, `'domain:{domain}'`.
  Default is `[]`.

- **`authoritative`**: _(Optional `bool`)_

  Whether to exclusively set `(authoritative mode)` or add `(non-authoritative/additive mode)` members to the role.
  Default is `true`.

## Module Attributes Reference

The following attributes are exported in the outputs of the module:

- **`module_enabled`**

  Whether this module is enabled.

- **`google_bigquery_dataset`**

  A map of outputs of the created google_project_iam_member resources keyed by role.

- **`iam`**

  The iam resource objects that define the access to the secret.

## External Documentation

- Google Documentation:
  - Bigquery Dataset: https://cloud.google.com/bigquery/docs/datasets-intro
  - Roles: https://cloud.google.com/bigquery/docs/share-access-views

- Terraform Google Provider Documentation:
  - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset
  -  https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset_iam

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

<!--
[![license][badge-license]][apache20]

This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE] for full details.
-->
Copyright &copy; 2020-2021 [Mineiros GmbH][homepage]


<!-- References -->

[homepage]: https://mineiros.io/?ref=terraform-module-template
[hello@mineiros.io]: mailto:hello@mineiros.io

<!-- markdown-link-check-disable -->

[badge-build]: https://github.com/mineiros-io/terraform-google-premium-modules/workflows/Tests/badge.svg

<!-- markdown-link-check-enable -->

[badge-semver]: https://img.shields.io/github/v/tag/mineiros-io/terraform-module-template.svg?label=latest&sort=semver
[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[badge-terraform]: https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform
[badge-slack]: https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack

<!-- markdown-link-check-disable -->

[build-status]: https://github.com/mineiros-io/terraform-google-premium-modules/modules/terraform-google-bigquery-dataset/actions
[releases-github]: https://github.com/mineiros-io/terraform-google-premium-modules/modules/terraform-google-bigquery-dataset/releases

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

[variables.tf]: https://github.com/mineiros-io/terraform-google-premium-modules/blob/modules/terraform-google-bigquery-dataset/main/variables.tf
[examples/]: https://github.com/mineiros-io/terraform-google-premium-modules/blob/modules/terraform-google-bigquery-dataset/main/examples
[issues]: https://github.com/mineiros-io/terraform-google-premium-modules/issues
[license]: https://github.com/mineiros-io/terraform-google-premium-modules/blob/main/LICENSE
[makefile]: https://github.com/mineiros-io/terraform-google-premium-modules/blob/main/Makefile
[pull requests]: https://github.com/mineiros-io/terraform-google-premium-modules/pulls
[contribution guidelines]: https://github.com/mineiros-io/terraform-google-premium-modules/blob/main/CONTRIBUTING.md

<!-- markdown-link-check-enable -->
