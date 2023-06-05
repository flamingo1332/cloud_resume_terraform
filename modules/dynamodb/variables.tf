
variable "visitor_table_name" {
  description = "Name of the visitor table"
  type        = string
  default     = "cloud_resume_visitor"
}

variable "ip_table_name" {
  description = "Name of the ip table"
  type        = string
  default     = "cloud_resume_ip"
}

variable "visitor_table_item" {
  description = "visitor table item"
  default = <<ITEM
  {
      "visitor" = {"S": "visitor"},
      "count" = {"N": "0"}
  }
  ITEM
    
}