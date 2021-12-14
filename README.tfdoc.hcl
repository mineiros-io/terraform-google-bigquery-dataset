
header {
  image = "https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg"
  url   = "https://mineiros.io/?ref=terraform-google-bigquery-dataset"

  badge "build" {
    image = "https://github.com/mineiros-io/terraform-google-bigquery-dataset/workflows/Tests/badge.svg"
    url   = "https://github.com/mineiros-io/terraform-google-bigquery-dataset/actions"
    text  = "Build Status"
  }

  badge "semver" {
    image = "https://img.shields.io/github/v/tag/mineiros-io/terraform-google-bigquery-dataset.svg?label=latest&sort=semver"
    url   = "https://github.com/mineiros-io/terraform-google-bigquery-dataset/releases"
    text  = "GitHub tag (latest SemVer)"
  }

  badge "terraform" {
    image = "https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform"
    url   = "https://github.com/hashicorp/terraform/releases"
    text  = "Terraform Version"
  }

  badge "tf-gcp-provider" {
    image = "https://img.shields.io/badge/google-4-1A73E8.svg?logo=terraform"
    url   = "https://github.com/terraform-providers/terraform-provider-google/releases"
    text  = "Google Provider Version"
  }

  badge "slack" {
    image = "https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack"
    url   = "https://mineiros.io/slack"
    text  = "Join Slack"
  }
}

section {
  title   = "terraform-google-bigquery-dataset"
  toc     = true
  content = <<-END
    A [Terraform](https://www.terraform.io) module to create a [Google Bigquery Dataset](https://cloud.google.com/bigquery/docs/datasets-intro) on [Google Cloud Services (GCP)](https://cloud.google.com/).

    **_This module supports Terraform version 1
    and is compatible with the Terraform Google Provider version 3._**

    This module is part of our Infrastructure as Code (IaC) framework
    that enables our users and customers to easily deploy and manage reusable,
    secure, and production-grade cloud infrastructure.
  END

  section {
    title   = "Module Features"
    content = <<-END
      A [Terraform] base module for creating a `google_bigquery_dataset` resources. Datasets are top-level containers that are used to organize and control access to your tables and views.
    END
  }

  section {
    title   = "Getting Started"
    content = <<-END
      Most basic usage just setting required arguments:

      ```hcl
      module "terraform-google-bigquery-dataset" {
        source = "github.com/mineiros-io/terraform-google-bigquery-dataset.git?ref=v0.1.0"

        dataset_id = "example_dataset"
      }
      ```
    END
  }

  section {
    title   = "Module Argument Reference"
    content = <<-END
      See [variables.tf] and [examples/] for details and use-cases.
    END

    section {
      title = "Top-level Arguments"

      section {
        title = "Module Configuration"

        variable "module_enabled" {
          type        = bool
          default     = true
          description = <<-END
            Specifies whether resources in the module will be created.
          END
        }

        variable "module_depends_on" {
          type           = any
          readme_type    = "list(dependencies)"
          description    = <<-END
            A list of dependencies. Any object can be _assigned_ to this list to define a hidden external dependency.
          END
          readme_example = <<-END
            module_depends_on = [
              google_network.network
            ]
          END
        }
      }

      section {
        title = "Main Resource Configuration"

        variable "dataset_id" {
          required    = true
          type        = string
          description = <<-END
            A unique ID for this dataset, without the project name.
          END
        }

        variable "friendly_name" {
          type        = string
          description = <<-END
            A descriptive name for the dataset.
          END
        }

        variable "description" {
          type        = string
          description = <<-END
            A user-friendly description of the dataset.
          END
        }

        variable "project" {
          type        = string
          description = <<-END
            The ID of the project in which the resource belongs.
            Default is the project that is configured in the provider.
          END
        }

        variable "location" {
          type        = string
          description = <<-END
            The geographic location where the dataset should reside.
          END
        }

        variable "default_table_expiration_ms" {
          type        = number
          default     = null
          description = <<-END
            The default lifetime of all tables in the dataset, in milliseconds.
            Once this property is set, all newly-created partitioned tables in the dataset will have an `expirationMs` property in the `timePartitioning` settings set to this value, and changing the value will only affect new tables, not existing ones. The storage in a partition will have an expiration time of its partition time plus this value. Setting this property overrides the use of `defaultTableExpirationMs` for partitioned tables: only one of `defaultTableExpirationMs` and `defaultPartitionExpirationMs` will be used for any new partitioned table. If you provide an explicit `timePartitioning.expirationMs` when creating or updating a partitioned table, that value takes precedence over the default partition expiration time indicated by this property.
          END
        }

        variable "default_partition_expiration_ms" {
          type        = number
          description = <<-END
            The default partition expiration for all partitioned tables in the dataset, in milliseconds.The minimum value is `3600000` milliseconds (one hour).
          END
        }

        variable "labels" {
          type        = map(string)
          default     = {}
          description = <<-END
            Key value pairs in a map for dataset lab.
          END
        }

        variable "access" {
          type        = list(any)
          readme_type = "list(access)"
          default     = []
          description = <<-END
            An array of objects that define dataset access for one or more entities.
          END

          attribute "domain" {
            type        = string
            description = <<-END
              A domain to grant access to. Any users signed in with the domain specified will be granted the specified access.
            END
          }

          attribute "role" {
            type        = string
            description = <<-END
              Describes the rights granted to the user specified by the other member of the access object. Basic, predefined, and custom roles are supported. Predefined roles that have equivalent basic roles are swapped by the API to their basic counterparts.
            END
          }

          attribute "group_by_email" {
            type        = string
            description = <<-END
              An email address of a Google Group to grant access to.
            END
          }

          attribute "user_by_email" {
            type        = string
            description = <<-END
              An email address of a Google User to grant access to.
            END
          }

          attribute "special_group" {
            type        = string
            description = <<-END
              A special group to grant access to. Possible values include:
              - `projectOwners`: Owners of the enclosing project.
              - `projectReaders`: Readers of the enclosing project.
              - `projectWriters`: Writers of the enclosing project.
              - `allAuthenticatedUsers`: All authenticated BigQuery users.
            END
          }
        }

        variable "view" {
          type        = any
          readme_type = "object(view)"
          default     = []
          description = <<-END
            A view from a different dataset to grant access to.
          END

          attribute "project_id" {
            required    = true
            type        = string
            description = <<-END
              The ID of the project containing this table.
            END
          }

          attribute "table_id" {
            required    = true
            type        = string
            description = <<-END
              The ID of the table.
            END
          }

          attribute "dataset_id" {
            required    = true
            type        = string
            description = <<-END
              The ID of the dataset containing this table.
            END
          }
        }

        variable "role" {
          type = any
          readme_type = "map(role)"
          default     = []
          description = <<-END
            (Optional) A map of dataset-level roles including the role, special_group, group_by_email, and user_by_email
          END
        }

        variable "default_encryption_configuration" {
          type        = any
          readme_type = "object(default_encryption_configuration)"
          description = <<-END
            The default encryption key for all tables in the dataset. Once this property is set, all newly-created partitioned tables in the dataset will have encryption key set to this value, unless table creation request (or query) overrides the key.
          END

          attribute "kms_key_name" {
            required    = true
            type        = string
            description = <<-END
              Describes the Cloud KMS encryption key that will be used to protect destination BigQuery table.
              The BigQuery Service Account associated with your project requires access to this encryption key.
            END
          }
        }

        variable "delete_contents_on_destroy" {
          type        = bool
          default     = false
          description = <<-END
            If set to true, delete all the tables in the dataset when destroying the resource; otherwise, destroying the resource will fail if tables are present.
          END
        }

        variable "authoritative" {
          type        = bool
          default     = true
          description = <<-END
            Whether to exclusively set (authoritative mode) or add (non-authoritative/additive mode) members to the role.
          END
        }

        variable "iam" {
          type        = list(any)
          readme_type = "list(iam)"
          default     = []
          description = <<-END
            A list of IAM access to apply to the created secret.
          END

          attribute "role" {
            required    = true
            type        = string
            description = <<-END
              The role that should be applied. Note that custom roles must be of the format [projects|organizations]/{parent-name}/roles/{role-name}.
            END
          }

          attribute "members" {
            type        = set(string)
            default     = []
            description = <<-END
              Identities that will be granted the privilege in role. Each entry can have one of the following values:
              - `allUsers`: A special identifier that represents anyone who is on the internet; with or without a Google account.
              - `allAuthenticatedUsers`: A special identifier that represents anyone who is authenticated with a Google account or a service account.
              - `user:{emailid}`: An email address that represents a specific Google account. For example, `alice@gmail.com` or `joe@example.com`.
              - `serviceAccount:{emailid}`: An email address that represents a service account. For example, `my-other-app@appspot.gserviceaccount.com`.
              - `group:{emailid}`: An email address that represents a Google group. For example, `admins@example.com`.
              - `domain:{domain}`: A G Suite domain (primary, instead of alias) name that represents all the users of that domain. For example, `google.com` or `example.com`.
            END
          }

          attribute "authoritative" {
            type        = bool
            default     = true
            description = <<-END
              Whether to exclusively set (authoritative mode) or add (non-authoritative/additive mode) members to the role.
            END
          }
        }
      }

      section {
        title = "Extended Resource Configuration"
      }
    }
  }

  section {
    title   = "Module Attributes Reference"
    content = <<-END
      The following attributes are exported in the outputs of the module:

      - **`module_enabled`**

        Whether this module is enabled.

      - **`google_bigquery_dataset`**

        A map of outputs of the created google_project_iam_member resources keyed by role.

      - **`iam`**

      The iam resource objects that define the access to the secret.
    END
  }

  section {
    title = "External Documentation"

    section {
      title   = "Google Documentation:"
      content = <<-END
        - Bigquery Dataset: <https://cloud.google.com/bigquery/docs/datasets-intro>
        - Bigquery Access Control: <https://cloud.google.com/bigquery/docs/access-control>
      END
    }

    section {
      title   = "Terraform Google Provider Documentation:"
      content = <<-END
        - <https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset>
        - <https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset_iam>
      END
    }
  }

  section {
    title   = "Module Versioning"
    content = <<-END
      This Module follows the principles of [Semantic Versioning (SemVer)].

      Given a version number `MAJOR.MINOR.PATCH`, we increment the:

      1. `MAJOR` version when we make incompatible changes,
      2. `MINOR` version when we add functionality in a backwards compatible manner, and
      3. `PATCH` version when we make backwards compatible bug fixes.
    END

    section {
      title   = "Backwards compatibility in `0.0.z` and `0.y.z` version"
      content = <<-END
        - Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
        - Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)
      END
    }
  }

  section {
    title   = "About Mineiros"
    content = <<-END
      [Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
      that solves development, automation and security challenges in cloud infrastructure.

      Our vision is to massively reduce time and overhead for teams to manage and
      deploy production-grade and secure cloud infrastructure.

      We offer commercial support for all of our modules and encourage you to reach out
      if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
      [Community Slack channel][slack].
    END
  }

  section {
    title   = "Reporting Issues"
    content = <<-END
      We use GitHub [Issues] to track community reported issues and missing features.
    END
  }

  section {
    title   = "Contributing"
    content = <<-END
      Contributions are always encouraged and welcome! For the process of accepting changes, we use
      [Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].
    END
  }

  section {
    title   = "Makefile Targets"
    content = <<-END
      This repository comes with a handy [Makefile].
      Run `make help` to see details on each available target.
    END
  }

  section {
    title   = "License"
    content = <<-END
      [![license][badge-license]][apache20]

      This module is licensed under the Apache License Version 2.0, January 2004.
      Please see [LICENSE] for full details.

      Copyright &copy; 2020-2022 [Mineiros GmbH][homepage]
    END
  }
}

references {
  ref "homepage" {
    value = "https://mineiros.io/?ref=terraform-google-bigquery-dataset"
  }
  ref "hello@mineiros.io" {
    value = "mailto:hello@mineiros.io"
  }
  ref "badge-build" {
    value = "https://github.com/mineiros-io/terraform-google-bigquery-dataset/workflows/Tests/badge.svg"
  }
  ref "badge-semver" {
    value = "https://img.shields.io/github/v/tag/mineiros-io/terraform-google-bigquery-dataset.svg?label=latest&sort=semver"
  }
  ref "badge-license" {
    value = "https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg"
  }
  ref "badge-terraform" {
    value = "https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform"
  }
  ref "badge-slack" {
    value = "https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack"
  }
  ref "build-status" {
    value = "https://github.com/mineiros-io/terraform-google-bigquery-dataset/actions"
  }
  ref "releases-github" {
    value = "https://github.com/mineiros-io/terraform-google-bigquery-dataset/releases"
  }
  ref "releases-terraform" {
    value = "https://github.com/hashicorp/terraform/releases"
  }
  ref "badge-tf-gcp" {
    value = "https://img.shields.io/badge/google-3.x-1A73E8.svg?logo=terraform"
  }
  ref "releases-google-provider" {
    value = "https://github.com/terraform-providers/terraform-provider-google/releases"
  }
  ref "apache20" {
    value = "https://opensource.org/licenses/Apache-2.0"
  }
  ref "slack" {
    value = "https://mineiros.io/slack"
  }
  ref "terraform" {
    value = "https://www.terraform.io"
  }
  ref "gcp" {
    value = "https://cloud.google.com/"
  }
  ref "semantic versioning (semver)" {
    value = "https://semver.org/"
  }
  ref "variables.tf" {
    value = "https://github.com/mineiros-io/terraform-google-bigquery-dataset/blob//main/variables.tf"
  }
  ref "examples/" {
    value = "https://github.com/mineiros-io/terraform-google-bigquery-dataset/blob/main/examples"
  }
  ref "issues" {
    value = "https://github.com/mineiros-io/terraform-google-bigquery-dataset/issues"
  }
  ref "license" {
    value = "https://github.com/mineiros-io/terraform-google-bigquery-dataset/blob/main/LICENSE"
  }
  ref "makefile" {
    value = "https://github.com/mineiros-io/terraform-google-bigquery-dataset/blob/main/Makefile"
  }
  ref "pull requests" {
    value = "https://github.com/mineiros-io/terraform-google-bigquery-dataset/pulls"
  }
  ref "contribution guidelines" {
    value = "https://github.com/mineiros-io/terraform-google-bigquery-dataset/blob/main/CONTRIBUTING.md"
  }
} 
