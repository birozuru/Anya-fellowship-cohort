packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "bootNode" {
  ami_name      = "polkadot-bootNode"
  instance_type = "t2.micro"
  region        = "us-east-1"
  access_key    = "AKIAWHUKW74SAIZ6ZN6O"
  secret_key    = "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"

  source_ami_filter {
    filters = {
      name                = "aerospike-ubuntu-20.04-20210322180709"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
      architecture        = "x86_64"
    }
    most_recent = true
    owners      = ["262212597706"]
  }
  ssh_username = "ubuntu"
  launch_block_device_mappings {
    device_name           = "/dev/sda1"
    volume_size           = 100
    volume_type           = "gp2"
    delete_on_termination = true
    encrypted             = true
  }
  tags = {
    OS_Version    = "Ubuntu"
    Base_Ami_Name = "{{ .SourceAMIName }}"
    Name          = "polkadot-fullNode0"
  }

  aws_polling {
    delay_seconds = 180
    max_attempts  = 100
  }

}

build {
  name = "bootNode"
  sources = [
    "source.amazon-ebs.bootNode"
  ]
  provisioner "shell" {
    script       = "scripts/install.sh"
    pause_before = "10s"
    timeout      = "10s"
  }


  post-processors {
    post-processor "manifest" {
      output     = "polkadot-bootNode-manifest.json"
      strip_path = true
    }
  }
  post-processors {
    post-processor "checksum" {
      checksum_types = ["md5", "sha512"] # Inspect artifact
    }
  }
}
