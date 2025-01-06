module "create-secrets" {
  for_each = var.secrets
  source   = "./allsecrets"
  kv_path  = each.key
  secret  = each.value
  token	= var.token
}

