variable "environment" {
  type = string
}

variable "project" {
    type = string
}

variable "dataset_name" {
  type = string
}

variable "dataset_fiendly_name" {
  type = string
}

variable "dataset_description" {
  type = string
}

variable "dataset_location" {
  type = string
}

variable "dataset_expiration" {
  type = number
}

variable "dataset_labels" {
  type = map(string)
}

variable "bq_admin" {
  type = string
}

variable "user_group_permision" {
  type = list(string)
}

variable "bucket_name" {
    type = string
}

variable "bucket_location" {
    type = string
}

variable "force_destroy" {
  type = bool
}

variable "uniform_bucket_level_access" {
  type = bool
}