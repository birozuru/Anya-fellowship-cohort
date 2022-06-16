#############################################
# RPC EBS VOLUME
#############################################
resource "aws_ebs_volume" "rpc-storage" {
  availability_zone = var.zone
  size              = 100
  count             = length(local.rpcnodes)
  encrypted         = true

  tags = {
    owner = var.name
  }
}

resource "aws_volume_attachment" "rpcnode-storage-attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.rpc-storage[index(local.rpcnodes, each.key)].id
  for_each    = toset(local.rpcnodes)
  instance_id = aws_instance.rpcnode[each.key].id

}

#############################################
# RPC NODE
#############################################
resource "aws_instance" "rpcnode" {
  ami           = var.image
  instance_type = var.machine_type
  key_name      = var.name
  for_each      = toset(local.rpcnodes)

  subnet_id              = aws_subnet.node.id
  vpc_security_group_ids = ["${aws_security_group.rpcnode.id}"]

  root_block_device {
    volume_size = 150
  }

  tags = {
    Name = var.name
  }
}

#############################################
# LOADBALANCER
#############################################

resource "aws_elb" "rpcnode" {
  name = "rpc-elb"

  subnets = ["${aws_subnet.node.id}"]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port     = 30333
    instance_protocol = "tcp"
    lb_port           = 30333
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 30334
    instance_protocol = "tcp"
    lb_port           = 30334
    lb_protocol       = "tcp"
  }
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

}

resource "aws_elb_attachment" "rpcnode" {
  for_each = aws_instance.rpcnode
  elb      = aws_elb.rpcnode.id
  instance = aws_instance.rpcnode[each.key].id
}