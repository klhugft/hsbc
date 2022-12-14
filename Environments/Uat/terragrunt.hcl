locals {
  gcp_project         = "pol-hsi-dev-001"
  gcp_region          = "europe-west3"
  gcp_env             = "uat"
  gcp_network_name    = "default"
  gcp_subnetwork_name = "default"
  gcp_group_list      = [ "user:E-PLKK@gft.com" ]
}

remote_state {
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    project        = local.gcp_project
    location       = local.gcp_region
    bucket         = "pol-hsi-dev-001-terrafom-state"
    prefix         = "${local.gcp_env}/${path_relative_to_include()}/terraform.tfstate"
  }
}


generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    provider "google" {
        project = "${local.gcp_project}"
        region = "${local.gcp_region}"
    }
    provider "google-beta" {
        project = "${local.gcp_project}"
        region = "${local.gcp_region}"
    }
    EOF
}