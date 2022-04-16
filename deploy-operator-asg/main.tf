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

module "iam" {
  source = "./modules/iam"

  aws_region                   = var.aws_region
  resource_name_prefix         = var.resource_name_prefix
  user_supplied_iam_role_name  = var.user_supplied_iam_role_name
}

module "networking" {
    source = "./modules/networking"
  
    public_subnet_tags = var.public_subnet_tags
    vpc_id              = var.vpc_id
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

resource "aws_launch_template" "operator" {
  name          = "${var.resource_name_prefix}-operator"
  image_id      = var.user_supplied_ami_id != null ? var.user_supplied_ami_id : data.aws_ami.amazon-linux-2[0].id
  instance_type = var.instance_type
  user_data     = filebase64("./modules/vm/psql.sh.tpl")
  vpc_security_group_ids = [
    aws_security_group.operator.id,
  ]

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_type           = "gp3"
      volume_size           = 100
      throughput            = 150
      iops                  = 3000
      delete_on_termination = true
    }
  }

  iam_instance_profile {
    name = module.iam.aws_iam_instance_profile
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
}

resource "aws_autoscaling_group" "op-asg" {
  name                = "${var.resource_name_prefix}-op-asg"
  min_size            = var.node_count
  max_size            = var.node_count
  desired_capacity    = var.node_count
  vpc_zone_identifier = module.networking.public_subnet_tags

  launch_template {
    id      = aws_launch_template.operator.id
    version = "$Latest"
  }

  tags = concat(
    [
      {
        key                 = "Name"
        value               = "${var.resource_name_prefix}-op-asg-server"
        propagate_at_launch = true
      }
    ],
    [
      {
        key                 = "${var.resource_name_prefix}-op-asg"
        value               = "server"
        propagate_at_launch = true
      }
    ],
    [
      for k, v in var.common_tags : {
        key                 = k
        value               = v
        propagate_at_launch = true
      }
    ]
  )
}
