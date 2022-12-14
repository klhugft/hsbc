locals {
    bucket_name = format("%s-%s",var.environment,var.bucket_name)
}

# ################################################## Ingestion Bucket Configuration ####################################################
# Create Ingestion Bucket
resource "google_storage_bucket" "gcs_ingestion_raw" {
  name          = local.bucket_name
  location      = var.bucket_location
  force_destroy = var.force_destroy

  uniform_bucket_level_access = var.uniform_bucket_level_access
}

# Create Ingestion Folders inside Ingestion bucket
resource "google_storage_bucket_object" "gcs_ingestion_folders" {
  for_each = toset(var.ingestion_folders)
  name   = format("%s/readme.txt",each.key)
  content = "readme"
  bucket = google_storage_bucket.gcs_ingestion_raw.id

  depends_on = [
    google_storage_bucket.gcs_ingestion_raw
  ]
}

# ################################################## Pub Sub  Configuration ###########################################################
# Pub Sub topic configuration
resource "google_pubsub_topic" "topics" {
  for_each = toset(var.ingestion_folders)
  name     = format("%s-%s-topic",var.environment,each.key)

  depends_on = [
    google_storage_bucket_object.gcs_ingestion_folders
  ]
}


# Bucket Notification Resources
resource "google_storage_notification" "gcp_bucket_notification" {
  for_each           = toset(var.ingestion_folders)
  bucket             = local.bucket_name
  payload_format     = "JSON_API_V1"
  topic              = format("%s-%s-topic",var.environment,each.key)
  object_name_prefix = each.key
  event_types        = var.event_types
  custom_attributes  = {}

  depends_on = [
    google_storage_bucket.gcs_ingestion_raw, 
    google_storage_bucket_object.gcs_ingestion_folders,
    google_pubsub_topic.topics
  ]
}

# Pub Sub subscription configuration
resource "google_pubsub_subscription" "gcp_pubsub_bucket_subcription" {
  for_each = toset(var.ingestion_folders)
  name  = format("%s-%s-subscription",var.environment,each.key)
  topic = format("%s-%s-topic",var.environment,each.key)

  ack_deadline_seconds = 600

  labels = {
    env = "${var.environment}",
    type = "ingestion",
    folder = "${each.key}"
  }

  push_config {
    push_endpoint = google_cloud_run_service.gcp_cloud_run_ingestion.status[0].url

    attributes = {
      x-goog-version = "v1"
    }

    oidc_token {
      service_account_email = data.google_service_account.cloud_run_invoker_sa.email
    }
  }

    depends_on = [
      google_storage_bucket.gcs_ingestion_raw, 
      google_storage_bucket_object.gcs_ingestion_folders,
      google_pubsub_topic.topics
  ]
}


# ################################################## cloud Run Configuration ##########################################################
# Cloud Run
resource "google_cloud_run_service" "gcp_cloud_run_ingestion" {
    name     = "process-masages-from-bucket-notification-${var.environment}"
    location = var.region
    template {
      spec {
            containers {
                image = var.cloud_run_img
            }
            service_account_name = data.google_service_account.cloud_run_invoker_sa.email
      }
    }
    traffic {
      percent         = 100
      latest_revision = true
    }
}

# ################################################## Permision Bindings Configuration #################################################
resource "google_cloud_run_service_iam_binding" "cloud_run_bucket_binding" {
  location = google_cloud_run_service.gcp_cloud_run_ingestion.location
  project = google_cloud_run_service.gcp_cloud_run_ingestion.project
  service = google_cloud_run_service.gcp_cloud_run_ingestion.name
  role = "roles/run.developer"
  members = var.user_group_permision
}

resource "google_storage_bucket_iam_binding" "ingestion_bucket_binding" {
  bucket = google_storage_bucket.gcs_ingestion_raw.name
  role = "roles/storage.admin"
  members = var.user_group_permision
}

resource "google_pubsub_subscription_iam_binding" "pubsub_subscription_binding" {
  for_each = google_pubsub_subscription.gcp_pubsub_bucket_subcription
  subscription = each.value.name
  role         = "roles/pubsub.editor"
  members = var.user_group_permision
}

resource "google_pubsub_topic_iam_binding" "pubsub_topic_binding" {
  for_each = google_pubsub_topic.topics
  topic = each.value.name
  role = "roles/pubsub.editor"
  members = var.user_group_permision
}