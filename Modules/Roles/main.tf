# locals {
#    flat_rbac_roles = flatten([
#          for iam in var.sa_details: flatten([
#             for members in iam["members"] : {
#                 id = "${iam.role}-${members}"
#                 role = iam.role
#                 member = members
#             }
#          ])
#    ])
# }


resource "google_project_iam_binding" "admin-account-iam" {
  for_each = var.sa_details
  project            = var.project
  role               = "roles/${each.value.role}"
  members            = [
    for member in each.value.members : "serviceAccount:${member}"
  ]
}