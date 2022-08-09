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
  instance_id = module.rpcnode[each.key].id
}

#############################################
# RPC NODE
#############################################
module "rpcnode" {
  source = "terraform-aws-modules/ec2-instance/aws"

  ami           = var.image
  instance_type = var.machine_type
  key_name      = var.name
  
  for_each      = toset(local.rpcnodes)

  subnet_id           = aws_subnet.node.id

  vpc_security_group_ids = ["${aws_security_group.rpcnode.id}"]

  root_block_device = [{
    encrypted  = true
    delete_on_termination = true
    volume_size = 150
  } ]

  tags = {
    Name = var.name
  }

}
