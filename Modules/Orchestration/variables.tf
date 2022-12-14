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

variable "user_group_permision" {
  type = list(string)
}

variable "env_name" {
  type = string
  description = "Environment name for composer"
  default = "composer-demo-hsi"
}

variable "img_version" {
  type = string
  description = "varsion of image for airflow/composer"
}

variable "composer_sa" {
  type = string
  description = "Service account which will be attached to composer resource"
}

variable "env_size" {
  type = string
  description = "Type of env to create plausable options: ENVIRONMENT_SIZE_SMALL, ENVIRONMENT_SIZE_MEDIUM, and ENVIRONMENT_SIZE_LARGE"
}

variable "scheduler" {
  type = object({
    cpu        = number
    memory_gb  = number
    storage_gb = number
    count      = number
  })
}

variable "web_server" {
  type = object({
    cpu        = number
    memory_gb  = number
    storage_gb = number
  })
}

variable "worker" {
  type = object({
    cpu = number
    memory_gb  = number
    storage_gb = number
    min_count  = number
    max_count  = number
  })
}

variable "node_machine_type" {
  type = string
  description = "type of node machines"
}

variable "ingestion_bucket_name" {
  type = string
}