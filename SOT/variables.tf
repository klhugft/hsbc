# General
variable "project" {
  type = string
}

variable "region" {
  type = string
}

# Variables Serviceaccounts

variable "service_accounts" {
  type = map(object({
    account_id      = string
    display_name    = string
    description     = string
  }))
}


# Variables for Roles

variable "sa_details" {
  type = map(object({
    role       = string
    members    = list(string)
  }))
}

# Variables for Apis

variable "api_name" {
    type = list(string)
}