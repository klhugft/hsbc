# Current Terragrunt file triggering Composer module to set up new environment

include "root" {
  path = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../..//Modules/Orchestration"
}

dependency "ingestion-module" {
  config_path = "../Ingestion"
}

inputs = {
    project               = include.root.locals.gcp_project
    region                = include.root.locals.gcp_region
    environment           = include.root.locals.gcp_env
    network_name          = include.root.locals.gcp_network_name
    subnetwork_name       = include.root.locals.gcp_subnetwork_name
    user_group_permision  = include.root.locals.gcp_group_list
  
# Composer Variables definition
    
    env_name = "composer-hsi-${include.root.locals.gcp_env}"
    img_version = "composer-2.0.22-airflow-2.2.5"
    composer_sa = "composer-sa-${include.root.locals.gcp_env}"

    env_size = "ENVIRONMENT_SIZE_SMALL"
    node_machine_type = "n1-standard-1"

    scheduler = {
        cpu        = 1
        memory_gb  = 1.875
        storage_gb = 1
        count      = 1
    }

    web_server = {
        cpu        = 1
        memory_gb  = 1.875
        storage_gb = 1
    }

    worker = {
        cpu = 1
        memory_gb  = 1.875
        storage_gb = 1
        min_count  = 1
        max_count  = 3
    }

    ingestion_bucket_name = dependency.ingestion-module.outputs.ingestion_bucket_name
}