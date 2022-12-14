output "composer-service-account" {
  value = data.google_service_account.composer_sa.email
}

output "composer_name" {
  value = google_composer_environment.gcp_composer_environment.name
}

output "composer_bucket_name" {
  value = split("/",google_composer_environment.gcp_composer_environment.config[0].dag_gcs_prefix)[2]
}

output "composer_airflow_uri" {
  value = google_composer_environment.gcp_composer_environment.config[0].airflow_uri
}

output "composer_cluster" {
  value = google_composer_environment.gcp_composer_environment.config[0].gke_cluster
}