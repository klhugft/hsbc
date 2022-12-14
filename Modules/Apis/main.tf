resource "google_project_service" "google_apis" {
  for_each = toset(var.api_name)
  project = var.project
  service = each.key

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}