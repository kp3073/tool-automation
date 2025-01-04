resource "vault_mount" "main" {
  for_each = var.secrets
  path        = each.key
  type        = "kv"
  options = { version = "1" }
  description = each.key
}

resource "vault_kv_secret" "secret" {
  path = "${vault_mount.main.path}/secret"
  data_json = jsonencode(
	{
	  zip = "zap",
	  foo = "bar"
	}
  )
}

variable "secrets" {
  default = {
	infrass = {}
	roboshop = {}
  }
}

