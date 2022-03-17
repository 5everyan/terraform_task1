provider "aws" {
    region = "eu-west-1"
}

data "aws_availability_zones" "available" {}
data "aws_vpcs" "my_vpcs" {}
data "aws_subnets" "vpc_subnets" {}
data "aws_subnet" "vpc_subnet" {
  for_each = toset(data.aws_subnets.vpc_subnets.ids)
  id       = each.value
}

data "aws_security_groups" "security_groups" {}

output "all_av_zones_names" {
  value = data.aws_availability_zones.available.names
}

output "all_av_zones_ids" {
  value = data.aws_availability_zones.available.zone_ids
}

output "aws_vpcs_ids" {
  value = data.aws_vpcs.my_vpcs.ids
}

output "aws_subnet_ids" {
  value = data.aws_subnets.vpc_subnets.ids
}

output "subnet_cidr_blocks" {
  value = [for s in data.aws_subnet.vpc_subnet : s.cidr_block]
}

output "aws_security_groups" {
  value = data.aws_security_groups.security_groups.ids
}