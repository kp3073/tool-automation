terraform {
  required_providers {
	github = {
	  source  = "integrations/github"
	  version = "6.5.0"
	}
  }
}

resource "github_repository" "example" {
  name        = "github-reusable-modules"
  visibility = "public"
}