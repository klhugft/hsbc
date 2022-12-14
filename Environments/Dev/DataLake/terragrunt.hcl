# Terragrunt file the trigger Terrafrom module DataLake responsible for creating bigQuery Datasets, External Buckets and Permissions to Bq.


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
    environment           = include.root.locals.gcp_env
    network_name          = include.root.locals.gcp_network_name
    subnetwork_name       = include.root.locals.gcp_subnetwork_name
    user_group_permision  = include.root.locals.gcp_group_list

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

    bucket_name = "hsi-external-bucket-dl"
    
    bucket_location  = "EU"
    force_destroy = false
    uniform_bucket_level_access  = true
}