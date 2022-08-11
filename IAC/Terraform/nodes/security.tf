resource "aws_security_group" "bootnode" {
  name   = "bootnode"
  vpc_id = aws_vpc.node.id
}

resource "aws_security_group" "collator" {
  name   = "collator"
  vpc_id = aws_vpc.node.id
}

resource "aws_security_group" "rpcnode" {
  name   = "rpcnode"
  vpc_id = aws_vpc.node.id
}

resource "aws_security_group_rule" "bootnode" {
  for_each          = toset(var.bootnode-ports)
  type              = "ingress"
  from_port         = each.key
  to_port           = each.key
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bootnode.id
}

resource "aws_security_group_rule" "rpcnode" {
  for_each          = toset(var.rpc-ports)
  type              = "ingress"
  from_port         = each.key
  to_port           = each.key
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rpcnode.id
}

resource "aws_security_group_rule" "rpc-internal" {
  for_each          = toset(var.collator-ports)
  type              = "ingress"
  from_port         = each.key
  to_port           = each.key
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] #change to internal access
  security_group_id = aws_security_group.rpcnode.id
}

resource "aws_security_group_rule" "collator-internal" {
  for_each          = toset(var.collator-ports)
  type              = "ingress"
  from_port         = each.key
  to_port           = each.key
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] #change to internal access
  security_group_id = aws_security_group.collator.id
}

resource "aws_security_group_rule" "collator" {
  for_each          = toset(var.bootnode-ports)
  type              = "ingress"
  from_port         = each.key
  to_port           = each.key
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.collator.id
}


resource "aws_security_group_rule" "collator-metrics" {
  for_each    = toset(var.metrics-ports)
  type        = "ingress"
  from_port   = each.key
  to_port     = each.key
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.collator.id
}

resource "aws_security_group_rule" "rpc-metrics" {
  for_each    = toset(var.metrics-ports)
  type        = "ingress"
  from_port   = each.key
  to_port     = each.key
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.rpcnode.id
}

resource "aws_security_group_rule" "bootnode-metrics" {
  for_each    = toset(var.metrics-ports)
  type        = "ingress"
  from_port   = each.key
  to_port     = each.key
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.bootnode.id
}



resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["160.119.126.13/32"]
  security_group_id = aws_security_group.bootnode.id
}

resource "aws_security_group_rule" "rpc_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["160.119.126.13/32"]
  security_group_id = aws_security_group.rpcnode.id
}

resource "aws_security_group_rule" "collator_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["160.119.126.13/32"]
  security_group_id = aws_security_group.collator.id
}

# resource "aws_security_group_rule" "bootnode_egress" {
#   for_each          = toset(var.bootnode-ports)
#   type              = "egress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.bootnode.id
# }

# resource "aws_security_group_rule" "rpc_egress" {
#   for_each          = toset(var.bootnode-ports)
#   type              = "egress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.rpcnode.id
# }

# resource "aws_security_group_rule" "collator_egress" {
#   for_each          = toset(var.bootnode-ports)
#   type              = "egress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.collator.id
# }