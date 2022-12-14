variable "environment" {
  type = string
}

variable "project" {
    type = string
}

variable "region" {
  type = string
}

variable "notification_group_email" {
    type = string
}

variable "log_dataset_name" {
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

variable "dataset_labels" {
  type = map(string)
}

variable "bq_log_sink_name" {
  type = string
}

