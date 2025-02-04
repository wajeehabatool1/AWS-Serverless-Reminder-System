variable "table_name" {
   description = "name of the dynamodb table"
   type = string
}

variable "billing_mode" {
  description = "billing mode of dynamodb"
  type = string
  default = "PAY_PER_REQUEST"
}

variable "ttl_attribute" {
  description = "time to live attribute name"
  type = string
}

