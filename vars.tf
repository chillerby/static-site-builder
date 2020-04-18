# Global vars
variable "site_hostname" {
  type = string
  description = "Address you want to be able to reach your site at"
}

variable "tags" {
  type        = map
  description = "Tags to apply to all resources"
}

# Lambda vars
variable "function_name" {
  type    = string
  default = "updateWebsite"
}

variable "github_account" {
  type        = string
  description = "Name of account or organisation where the repo containing the Hugo site exists"
}

variable "github_repo" {
  type        = string
  description = "Name of the repo containing the Hugo site"
}
