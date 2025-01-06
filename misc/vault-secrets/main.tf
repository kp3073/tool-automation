module "create-secrets" {
  for_each = var.secrets
  source   = "./create-sercrets"
  kv_path  = each.key
  secrets  = each.value
}


variable "secrets" {
  default = {
    infra = {
      ssh = {
        admin_username = "roboshop-ansible",
        admin_password = "DevOps@123456"
      }
    }
  }
}