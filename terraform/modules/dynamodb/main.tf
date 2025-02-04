resource "aws_dynamodb_table" "reminders" {
  name = var.table_name
  billing_mode = var.billing_mode

  attribute {
    name = "name"
    type = "S"
   }

   attribute {
     name = "reminderId"
     type = "N"
   }

   hash_key = "name"
   range_key = "reminderId"

   stream_enabled = true
   stream_view_type = "NEW_AND_OLD_IMAGES"

   ttl{
    attribute_name = var.ttl_attribute
    enabled = true
   }
}