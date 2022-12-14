data "google_service_account" "cloud_bq_admin_sa" {
  account_id = var.bq_admin
}