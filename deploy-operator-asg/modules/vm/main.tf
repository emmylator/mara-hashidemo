data "aws_ami" "amazon-linux-2" {
  count       = var.user_supplied_ami_id != null ? 0 : 1
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_security_group" "operator" {
  name   = "${var.resource_name_prefix}-operator"
  vpc_id = var.vpc_id

  tags = merge(
    { Name = "${var.resource_name_prefix}-operator-sg" },
    var.common_tags,
  )
}

resource "aws_security_group_rule" "operator_outbound" {
  description       = "Allow EC2 to send outbound traffic"
  security_group_id = aws_security_group.operator.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_instance" "operator" {
  ami           = var.user_supplied_ami_id != null ? var.user_supplied_ami_id : data.aws_ami.amazon-linux-2[0].id
  instance_type = var.instance_type
  user_data     = filebase64("./modules/vm/psql.sh.tpl")
  vpc_security_group_ids = [
    aws_security_group.operator.id,
  ]

  iam_instance_profile      = var.aws_iam_instance_profile

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

 subnet_id = "${var.subnet_prv1}"
}
