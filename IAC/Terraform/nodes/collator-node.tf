#############################################
# COLLATOR EBS VOLUME 
#############################################
resource "aws_ebs_volume" "collator" {
  availability_zone = var.zone
  size              = 100
  encrypted         = true

  tags = {
    owner = var.name
  }
}

resource "aws_volume_attachment" "collator-storage-attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.collator.id
  instance_id = module.collatornode.id
}

#############################################
# COLLATOR NODE
#############################################
module "collatornode" {
  source = "terraform-aws-modules/ec2-instance/aws"

  ami           = var.image
  instance_type = var.machine_type
  key_name      = var.name
  name          = "collator-node"

  subnet_id           = aws_subnet.node.id

  vpc_security_group_ids = ["${aws_security_group.collator.id}"]

  root_block_device = [{
    encrypted  = true
    delete_on_termination = true
    volume_size = 150
  } ]

  tags = {
    Name = var.name
  }

}
