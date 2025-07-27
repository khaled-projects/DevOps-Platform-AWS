resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = "${var.name_prefix}-vpc"
  }
}
resource "aws_subnet" "public" {
  for_each             = { for idx, cidr in var.public_subnets : idx => cidr }
  vpc_id               = aws_vpc.this.id
  cidr_block           = each.value
  availability_zone    = element(data.aws_availability_zones.available.names, each.key)
  map_public_ip_on_launch = true
  tags = { Name = "${var.name_prefix}-public-subnet-${each.key}" }
}

resource "aws_subnet" "private" {
  for_each             = { for idx, cidr in var.private_subnets : idx => cidr }
  vpc_id               = aws_vpc.this.id
  cidr_block           = each.value
  availability_zone    = element(data.aws_availability_zones.available.names, each.key)
  tags = { Name = "${var.name_prefix}-private-subnet-${each.key}" }
}

data "aws_availability_zones" "available" {}
