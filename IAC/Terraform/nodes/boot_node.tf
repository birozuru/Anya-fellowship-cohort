resource "aws_key_pair" "key-node" {
  key_name   = var.name
  public_key = var.public_key
}

module "bootnode" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.1.2"

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.machine_type
  key_name      = var.name
  monitoring    = true

  for_each = toset(local.bootnodes)

  subnet_id = aws_subnet.node.id

  vpc_security_group_ids = ["${aws_security_group.bootnode.id}"]

  root_block_device = [{
    encrypted             = true
    delete_on_termination = true
    volume_size           = 150
  }]

  tags = {
    Name = var.name
  }

}

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
  instance_id = module.bootnode[each.key].id

}