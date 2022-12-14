output "ingestion_bucket_name" {
  value = google_storage_bucket.gcs_ingestion_raw.name
}

output "cloud_run_url" {
  value = google_cloud_run_service.gcp_cloud_run_ingestion.status[0].url
}

output "run_invoker-sa" {
  value = data.google_service_account.cloud_run_invoker_sa.email
}