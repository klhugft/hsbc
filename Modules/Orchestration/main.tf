# ################################################## composer Configuration ###########################################################
# Composer

resource "google_composer_environment" "gcp_composer_environment" {
  name = var.env_name 
  project = var.project
  region = var.region

  config {

    software_config {
      image_version = var.img_version

      env_variables = {
        GCP_GCS_INGESTION = var.ingestion_bucket_name
        GCP_PROJECT_ID    = var.project
      }
    }

    workloads_config {
      scheduler {
        cpu        = var.scheduler.cpu
        memory_gb  = var.scheduler.memory_gb
        storage_gb = var.scheduler.storage_gb
        count      = var.scheduler.count
      }
      web_server {
        cpu        = var.web_server.cpu
        memory_gb  = var.web_server.memory_gb
        storage_gb = var.web_server.storage_gb
      }
      worker {
        cpu        = var.worker.cpu
        memory_gb  = var.worker.memory_gb
        storage_gb = var.worker.storage_gb
        min_count  = var.worker.min_count
        max_count  = var.worker.max_count
      }
    }

    environment_size = var.env_size

    node_config {
      network    = var.network_name
      subnetwork = var.subnetwork_name
      service_account = data.google_service_account.composer_sa.email
    }
  }

}

# ################################################## Permision Bindings Configuration #################################################
resource "google_storage_bucket_iam_binding" "composer_bucket_binding" {
  bucket = split("/",google_composer_environment.gcp_composer_environment.config[0].dag_gcs_prefix)[2]
  role = "roles/storage.admin"
  members = var.user_group_permision
}