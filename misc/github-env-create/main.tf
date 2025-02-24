variable "github_token" {}

terraform {
  required_providers {
	github = {
	  source  = "integrations/github"
	  version = "6.5.0"
	}
  }
}

provider "github" {
  # Configuration options
  owner = "azawsdevops"
  token = var.github_token
}

data "github_user" "current" {
  username = "kp3073"
}

variable "repos" {
  default = ["roboshop-cart", "roboshop-user", "roboshop-shipping","roboshop-payment", "roboshop-frontend"]
}

resource "github_repository_environment" "example" {
  count = length(var.repos)
  environment         = "DEV"
  repository          = var.repos[count.index]
  prevent_self_review = false
  reviewers {
	users = [data.github_user.current.id]
  }
}