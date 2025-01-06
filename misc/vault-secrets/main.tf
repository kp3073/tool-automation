module "create-secrets" {
  for_each = var.secrets
  source   = "./create-secrets"
  kv_path  = each.key
  secret  = each.value
  token	= var.token
}

