variable "environment" {
  type = string
}

variable "project" {
    type = string
}

variable "region" {
  type = string
}

variable "network_name" {
  type = string
  description = "Composer gke node network"
}

variable "subnetwork_name" {
  type = string
  description = "Subnetwork for gke/composer node pool"
}

variable "bucket_name" {
    type = string
}

variable "bucket_location" {
    type = string
}

variable "force_destroy" {
  type = bool
}

variable "uniform_bucket_level_access" {
  type = bool
}

variable "ingestion_folders" {
    type = list(string)
    description = "List of folder to create for daily,full and cdc files" 
}

variable "cloud_run_invoker_sa" {
  type = string
}

variable "event_types" {
  type = list(string)
  default = [ "OBJECT_FINALIZE", "OBJECT_METADATA_UPDATE"]
}

variable "user_group_permision" {
  type = list(string)
}

variable "cloud_run_img" {
  type = string
  description = "image for cloud run"
}