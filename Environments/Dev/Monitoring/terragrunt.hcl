include "root" {
  path = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../..//Modules/Monitoring"
}

inputs = {
    project               = include.root.locals.gcp_project
    region                = include.root.locals.gcp_region
    environment           = include.root.locals.gcp_env
    network_name          = include.root.locals.gcp_network_name
    subnetwork_name       = include.root.locals.gcp_subnetwork_name
    user_group_permision  = ["PRKI@gft.com"]

    log_dataset_name      = "log_sink_dataset_${include.root.locals.gcp_env}"
    dataset_fiendly_name  = "log_sink_dataset"
    dataset_description   = "Dataset for ${include.root.locals.gcp_env} logs"
    dataset_location      = "EU"
    dataset_labels        = {
        "environment" = include.root.locals.gcp_env
        "type"        = "logs"
        }
    bq_log_sink_name     = "logs-composer-${include.root.locals.gcp_env}"
    notification_group_email = "klbn@gft.com"
}
