resource "vault_mount" "main" {
  for_each = var.secrets
  path        = each.key
  type        = "kv"
  options = { version = "1" }
  description = each.key
}

resource "vault_kv_secret" "secret" {
  path = "infra/ssh"
  data_json = jsonencode()
}

variable "secrets" {
  default = {
	infra = {}
	roboshop = {}
  }
}

