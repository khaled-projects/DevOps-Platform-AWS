variable "domain_name" {
  type = string
}

variable "record_name" {
  type = string
}

variable "alias_target" {
  description = "CloudFront distribution domain"
  type        = string
}
