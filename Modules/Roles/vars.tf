variable "project" {
  type = string
}

variable "sa_details" {
  type = map(object({
    role = string
    members    = list(string)
  }))
}