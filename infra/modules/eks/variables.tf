
variable "cluster_name" {
  type        = string
}

variable "cluster_version" {
  type        = string
  default     = "1.24"
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "node_group" {
  type = object({
    desired_capacity = number
    max_capacity     = number
    min_capacity     = number
    instance_types   = list(string)
  })
}

variable "tags" {
  type    = map(string)
  default = {}
}

