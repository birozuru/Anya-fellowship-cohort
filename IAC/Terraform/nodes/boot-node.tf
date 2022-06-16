#############################################
# LOCAL VALUES
#############################################
locals {
  name      = "polkadot"
  bootnodes = ["${local.name}-bootnode-1", "${local.name}-bootnode-2"]
  rpcnodes  = ["${local.name}-rpcnode-1", "${local.name}-rpcnode-2"]

  tags = {
    Terraform = "true"
  }
}

#############################################
# KEY PAIR
#############################################
resource "aws_key_pair" "key-node" {
  key_name   = var.name
  public_key = var.public_key
}

#############################################
# BOOT NODE EBS VOLUME
#############################################
resource "aws_ebs_volume" "node-storage" {
  availability_zone = var.zone
  size              = 100
  count             = length(local.bootnodes)
  encrypted         = true

  tags = {
    owner = var.name
  }
}

resource "aws_volume_attachment" "bootnode-storage-attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.node-storage[index(local.bootnodes, each.key)].id
  for_each    = toset(local.bootnodes)
  instance_id = aws_instance.bootnode[each.key].id

}

#############################################
# BOOT NODE
#############################################
resource "aws_instance" "bootnode" {
  ami           = var.image
  instance_type = var.machine_type
  key_name      = var.name
  for_each      = toset(local.bootnodes)

  subnet_id              = aws_subnet.node.id
  vpc_security_group_ids = ["${aws_security_group.bootnode.id}"]

  root_block_device {
    volume_size = 150
  }

  tags = {
    Name = var.name
  }
}