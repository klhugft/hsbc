output "bq_dataset_owner" {
  value = data.google_service_account.cloud_bq_admin_sa.email
}

# output "bq_dataset_name" {
#   value = google_bigquery_dataset.big_query_dataset_ingestion.dataset_id
# }