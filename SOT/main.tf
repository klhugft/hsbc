module "enable_apis" {
  source = "../Modules/Apis"

  api_name   = var.api_name
  project = var.project
  
}

module "create_service_account" {
    source = "../Modules/ServiceAccounts"

    service_accounts = var.service_accounts

    depends_on = [
      module.enable_apis
    ]
}

module "create_role_bindings" {
    source = "../Modules/Roles"

    project = var.project
    sa_details = var.sa_details

    depends_on = [
      module.create_service_account
    ]
}