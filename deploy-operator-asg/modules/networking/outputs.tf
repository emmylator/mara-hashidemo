output "public_subnet_tags" {
  value = data.aws_subnet_ids.operator.ids
}

output "vpc_id" {
  value = data.aws_vpc.selected.id
}
