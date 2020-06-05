# Global vars
variable "site_address" {
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

# Route 53 vars
variable "domain" {
  type        = string
  description = "Name of the domain you own and would like the site to be hosted on"
}

variable "create_domain_zone" {
  type        = bool
  description = "Whether or not to create the public domain zone your site will be hosted on"
  default     = true
}
