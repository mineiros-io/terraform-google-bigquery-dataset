# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# These variables must be set when using this module.
# ---------------------------------------------------------------------------------------------------------------------

variable "dataset_id" {
  type        = string
  description = "(Required) A unique ID for this dataset, without the project name. The ID must contain only letters (a-z, A-Z), numbers (0-9), or underscores (_). The maximum length is 1,024 characters."

  validation {
    condition     = length(var.dataset_id) >= 1 && length(var.dataset_id) <= 1024
    error_message = "A unique id maximuim length is 1024."
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL VARIABLES
# These variables have defaults, but may be overridden.
# ---------------------------------------------------------------------------------------------------------------------

variable "friendly_name" {
  type        = string
  description = "(Optional) Friendly name for the dataset being provisioned."
  default     = null
}

variable "description" {
  type        = string
  description = "(Optional) A user-friendly description of the dataset"
  default     = null
}

variable "project" {
  type        = string
  description = "Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  default     = null
}

variable "location" {
  type        = string
  description = "(Optional) The geographic location where the dataset should reside"
  default     = null
}

variable "default_table_expiration_ms" {
  type        = number
  description = "The default lifetime of all tables in the dataset, in milliseconds."
  default     = null

  validation {
    condition     = var.default_table_expiration_ms == null ? true : var.default_table_expiration_ms >= 3600000
    error_message = "The minimum value is 3600000 milliseconds (one hour)."
  }
}

variable "default_partition_expiration_ms" {
  type        = number
  description = "The default partition expiration for all partitioned tables in the dataset, in milliseconds"
  default     = null
}

variable "labels" {
  description = "(Optional) Key value pairs in a map for dataset labels"
  type        = map(string)
  default     = {}
}

variable "max_time_travel_hours" {
  description = "(Optional) Defines the time travel window in hours. The value can be from 48 to 168 hours (2 to 7 days)."
  type        = number
  default     = null
}

variable "external_dataset_reference" {
  description = "(Optional) Information about the external metadata storage where the dataset is defined."
  type        = any
  default     = null

  ## Attributes:
  # external_source - (Required) External source that backs this dataset.
  # connection - (Required) The connection id that is used to access the externalSource. Format: projects/{projectId}/locations/{locationId}/connections/{connectionId}
}

variable "is_case_insensitive" {
  description = "(Optional) TRUE if the dataset and its table names are case-insensitive, otherwise FALSE. By default, this is FALSE, which means the dataset and its table names are case-sensitive. This field does not affect routine references."
  type        = bool
  default     = false
}

variable "resource_tags" {
  description = "(Optional) The tags attached to this table. Tag keys are globally unique. Tag key is expected to be in the namespaced format, for example \"123456789012/environment\" where 123456789012 is the ID of the parent organization or project resource for this tag key. Tag value is expected to be the short name, for example \"Production\"."
  type        = any
  default     = null
}

variable "access" {
  # type = list(object({
  # #(Optional) A domain to grant access to. Any users signed in with the domain specified will be granted the specified access
  # domain = string
  # #(Optional) Describes the rights granted to the user specified by the other member of the access object. Basic, predefined, and custom roles are supported.
  # role = string
  # #(Optional) An email address of a Google Group to grant access to.
  # group_by_email = string
  # #(Optional) An email address of a user to grant access to.
  # user_by_email = string
  # #(Optional) A special group to grant access to. Possible values include:
  # #projectOwners: Owners of the enclosing project.
  # #ProjectReaders: Readers of the enclosing project.
  # #projectWriters: Writers of the enclosing project.
  # #allAuthenticatedUsers: All authenticated BigQuery users.
  # special_group = string
  # }))

  type        = any
  description = "(Optional) An array of objects that define dataset access for one or more entities."
  # At least one owner access is required.
  default = []
}


variable "view" {

  # type = list(object({
  #   #(Required) The ID of the project containing this table.
  #   project_id = string
  #   #(Required) The ID of the dataset containing this table
  #   dataset_id = string
  #   #(Required) The ID of the table. The ID must contain only letters (a-z, A-Z), numbers (0-9), or underscores (_).
  #   table_id   = string

  #   validation {
  #     condition = length(var.view.table_id) >= 1 && length(var.view.table_id) <= 1024
  #     error_message = "Table ID maximum length is 1,024 characters."
  #   }
  # }))
  type        = any
  description = "(Optional) A view from a different dataset to grant access to."
  default     = []
}

variable "role" {
  description = "(Optional) A map of dataset-level roles including the role, special_group, group_by_email, and user_by_email"
  default     = []
  type        = any
  #type = list(object({
  #  role           = string
  #  special_group  = string
  #  group_by_email = string
  #  user_by_email  = string
  #}))
}

variable "default_encryption_configuration" {
  description = "(Optional) The default encryption key for all tables in the dataset. Once this property is set, all newly-created partitioned tables in the dataset will have encryption key set to this value, unless table creation request (or query) overrides the key"
  type        = any
  default     = null

  # (Required) Describes the Cloud KMS encryption key that will be used to protect destination BigQuery table.
  # The BigQuery Service Account associated with your project requires access to this encryption key.
  # kms_key_name = string
}

variable "delete_contents_on_destroy" {
  type        = bool
  description = "(Optional) If set to true, delete all the tables in the dataset when destroying the resource; otherwise, destroying the resource will fail if tables are present."
  default     = false
}

variable "authoritative" {
  description = "(Optional) google bigquery dataset iam choice whether 'authoritative == true' use google_bigquery_iam_binding, 'authoritative == false' use google_bigquery_iam_member"
  type        = bool
  default     = true
}


## IAM

variable "iam" {
  type        = any
  description = "(Optional) A list of IAM access to apply to the created BigQuery dataset"
  default     = []
}

# ------------------------------------------------------------------------------
# MODULE CONFIGURATION PARAMETERS
# These variables are used to configure the module.
# See https://medium.com/mineiros/the-ultimate-guide-on-how-to-write-terraform-modules-part-1-81f86d31f024
# ------------------------------------------------------------------------------

variable "module_enabled" {
  type        = bool
  description = "(Optional) Whether to create resources within the module or not. Default is 'true'."
  default     = true
}

variable "module_depends_on" {
  type        = any
  description = "(Optional) A list of external resources the module depends_on. Default is '[]'."
  default     = []
}
