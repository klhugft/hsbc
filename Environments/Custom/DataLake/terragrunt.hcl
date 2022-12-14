include "root" {
  path = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../..//Modules/DataLake"
}

inputs = {
    project               = include.root.locals.gcp_project
    region                = include.root.locals.gcp_region
    network_name          = include.root.locals.gcp_network_name
    subnetwork_name       = include.root.locals.gcp_subnetwork_name

    dataset_name          = "ingestion_raw"
    dataset_fiendly_name  = "ingestion"
    dataset_description   = "Dataset for raw ingestions"
    dataset_location      = "EU"
    dataset_expiration    = 3600000
    dataset_labels        = {
        "environment" = include.root.locals.gcp_env
        "type"        = "ingestion"
        }
    bq_admin              = "big-query-data-admin"
}