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
  instance_id = aws_instance.collator.id
}

#############################################
# COLLATOR NODE
#############################################
resource "aws_instance" "collator" {
  ami           = var.image
  instance_type = var.machine_type
  key_name      = var.name

  subnet_id              = aws_subnet.node.id
  vpc_security_group_ids = ["${aws_security_group.collator.id}"]

  root_block_device {
    volume_size = 150
  }

  tags = {
    Name = var.name
  }
}