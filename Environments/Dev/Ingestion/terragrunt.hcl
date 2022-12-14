#Terragrunt Module triggering terraform module responsible for creating PubSub Topics, Subscriptions, Ingestion Buckets and Notifications 

include "root" {
  path = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../..//Modules/Ingestion"
}

inputs = {
    project               = include.root.locals.gcp_project
    region                = include.root.locals.gcp_region
    environment           = include.root.locals.gcp_env
    network_name          = include.root.locals.gcp_network_name
    subnetwork_name       = include.root.locals.gcp_subnetwork_name
    user_group_permision  = include.root.locals.gcp_group_list
  
    bucket_name = "hsi-injection-bucket-raw"
    
    bucket_location  = "EU"
    force_destroy = false
    uniform_bucket_level_access  = true
    
    ingestion_folders = ["daily_snapshot","full_snapshot","cdc_delta"]

    cloud_run_invoker_sa = "cloud-run-pubsub-invoker-${include.root.locals.gcp_env}"

    cloud_run_img = "gcr.io/pol-hsi-dev-001/ingestion_cloudrun"
}