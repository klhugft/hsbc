#  Notification chanell group for email 
resource "google_monitoring_notification_channel" "gcp-notification-channel" {
  display_name = "${var.environment} notification channel"
  type         = "email"
  labels = {
    email_address = var.notification_group_email
  }
}

# Bq log sink 
resource "google_bigquery_dataset" "big_query_log_sink" {
  project                     = var.project
  dataset_id                  = var.log_dataset_name
  friendly_name               = var.dataset_fiendly_name
  description                 = var.dataset_description
  location                    = var.dataset_location
  delete_contents_on_destroy  = true

  labels = var.dataset_labels
}

# Our sink; this logs all activity related to our project
resource "google_logging_project_sink" "composer_logs_sinks" {
  name        = format("%s-%s",var.bq_log_sink_name,var.environment)
  description = "Sink for storing logs from stack driver used in datastudio Demo"
  destination = "bigquery.googleapis.com/projects/${var.project}/datasets/${google_bigquery_dataset.big_query_log_sink.dataset_id}"
  filter      = "severity=\"INFO\" OR severity=\"ERROR\" OR severity=\"WARNING\" resource.type=\"cloud_composer_environment\""
  
#  resource.labels.environment_name=has_substring(\"${var.environment}\")

  bigquery_options {
          use_partitioned_tables = true
  }

  unique_writer_identity = true
}

# Because our sink uses a unique_writer, we must grant that writer access to the bq.
resource "google_bigquery_dataset_access" "ingestions_dataset_owner" {
  dataset_id    =  google_bigquery_dataset.big_query_log_sink.dataset_id
  role          = "roles/bigquery.dataEditor"
  user_by_email = split(":",google_logging_project_sink.composer_logs_sinks.writer_identity)[1]
}

