module "create-secrets" {
  for_each = var.secrets
  source   = "./create-secrets"
  kv_path  = each.key
  secrets  = each.value
}


variable "secrets" {
  default = {
    infra = {
      ssh = {
        ssh_username = "roboshop-ansible",
        ssh_password = "DevOps@123456"
      }
    }
    roboshop-dev = {
      frontend = {
        catalogue_endpoint = "http://catalogue-dev.cloudaws.shop:8080"
        cart_endpoint      = "http://cart-dev.cloudaws.shop:8080"
        user_endpoint      = "http://user-dev.cloudaws.shop:8080"
        payment_endpoint   = "http://payment-dev.cloudaws.shop:8080"
        shipping_endpoint  = "http://shipping-dev.cloudaws.shop:8080"
        CATALOGUE_HOST     = "catalogue-dev.cloudaws.shop"
        CATALOGUE_PORT     = "8080"
        USER_HOST          = "user-dev.cloudaws.shop"
        USER_PORT          = "8080"
        CART_HOST          = "cart-dev.cloudaws.shop"
        CART_PORT          = "8080"
        SHIPPING_HOST      = "shipping-dev.cloudaws.shop"
        SHIPPING_PORT      = "8080"
        PAYMENT_HOST       = "payment-dev.cloudaws.shop"
        PAYMENT_PORT       = "8080"

      }
      catalogue = {
        MONGO       = "true"
        MONGO_URL   = "mongodb://mongodb-dev.cloudaws.shop:27017/catalogue"
        DB_TYPE     = "mongo"
        APP_GIT_URL = "https://github.com/roboshop-devops-project-v3/catalogue"
        DB_HOST     = "mongodb-dev.cloudaws.shop"
        SCHEMA_FILE = "db/master-data.js"
      }
      user = {
        MONGO     = "true"
        REDIS_URL = "redis://redis-dev.cloudaws.shop:6379"
        MONGO_URL = "mongodb://mongodb-dev.cloudaws.shop:27017/users"
      }
      cart = {
        REDIS_HOST     = "redis-dev.cloudaws.shop"
        CATALOGUE_HOST = "catalogue-dev.cloudaws.shop"
        CATALOGUE_PORT = "8080"
      }
      shipping = {
        CART_ENDPOINT = "cart-dev.cloudaws.shop:8080"
        DB_HOST       = "mysql-dev.cloudaws.shop"
        DB_TYPE       = "mysql"
        APP_GIT_URL   = "https://github.com/roboshop-devops-project-v3/shipping"
        DB_HOST       = "mysql-dev.cloudaws.shop"
        DB_USER       = "root"
        DB_PASS       = "RoboShop@1"
      }
      payment = {
        CART_HOST = "cart-dev.cloudaws.shop"
        CART_PORT = "8080"
        USER_HOST = "user-dev.cloudaws.shop"
        USER_PORT = "8080"
        AMQP_HOST = "rabbitmq-dev.cloudaws.shop"
        AMQP_USER = "roboshop"
        AMQP_PASS = "roboshop123"
      }
      mysql = {
        MYSQL_ROOT_PASSWORD = "RoboShop@1"
      }
      rabbitmq = {
        AMQP_USER = "roboshop"
        AMQP_PASS = "roboshop123"
      }
    }
  }
}