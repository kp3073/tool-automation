

terraform {
  required_providers {
	github = {
	  source  = "integrations/github"
	  version = "6.5.0"
	}
  }
}
variable "github_token" {}
provider "github" {
  # Configuration options
  owner = "kp3073"
  token = var.github_token
}



resource "github_repository" "example" {
  name        = "github-reusable-modules"
  visibility = "public"
}