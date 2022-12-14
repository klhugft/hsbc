locals {
  user_group = [for user in var.user_group_permision : split(":",user)[1]]
}

resource "google_bigquery_dataset" "big_query_dataset_ingestion" {
  project                     = var.project
  dataset_id                  = format("%s_%s",var.dataset_name,var.environment)
  friendly_name               = var.dataset_fiendly_name
  description                 = var.dataset_description
  location                    = var.dataset_location
  default_table_expiration_ms = var.dataset_expiration

  labels = var.dataset_labels
}

resource "google_storage_bucket" "bq_external_table" {
  name          = format("%s-%s",var.environment,var.bucket_name)
  location      = var.bucket_location
  force_destroy = var.force_destroy

  uniform_bucket_level_access = var.uniform_bucket_level_access
}

resource "google_bigquery_dataset_access" "ingestions_dataset_owner" {
  dataset_id    =  google_bigquery_dataset.big_query_dataset_ingestion.dataset_id
  role          = "OWNER"
  user_by_email = data.google_service_account.cloud_bq_admin_sa.email
}

resource "google_bigquery_dataset_access" "ingestions_dataset_reader" {
  for_each      =  toset(local.user_group)
  dataset_id    =  google_bigquery_dataset.big_query_dataset_ingestion.dataset_id
  role          = "READER"
  user_by_email = each.key
}
