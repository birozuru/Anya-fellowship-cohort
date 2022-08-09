variable "access_key" {}
variable "secret_key" {}

variable "location" {
  default = "us-east-1"
}

variable "zone" {
  default = "us-east-1d"
}

variable "machine_type" {
  default = "t2.micro"
}

variable "public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDYLs1JZOkW/mMxvuZT1NJYsJKQAaRFgutagylQ/RV2+WpiFwAdEZa2X5fYY2iQPZAIeJ9K80iLNY8xJNwwjiV+8bojApeeSe1u9Ee3Py+6i7xIMtyKnEyUW90XOWrf6yvv3Mj1Wl9Zk6Qg+rlIoBkvLVCDnmK1XXjhhFGdh8aXsBfXx+AcDEBk3xb5oyErmxT2G9C2NE161d6uaC4d0OMBS+AzBnOy7X9QpDclS35rQaSdZpl6r+pwRdg3j6aiz8aeC4a/ydwzXL/3Nr7NdbUaap9s8g1zbjgPhH9Fx49ET9a3czo9fpfjQu7uwCxmPPONmNoBUiOA+Q31nK63Z5mtwwFk/a8w94TeJ5PGaG0RxG+9ndAMxQHBecxdNoR2zXa9O+AZj9t8is6STL3w25eyP5QyV8BFPmk5TDsAx3gn/CuoTD3AZMRBFHy4DfeEuFMisUiryJAVEOPVkqx4niLD1UdYwFGOT0jQIQSEtl6JVBmhL797GW0t0JHkMwpTep0= marcel@Marks-MacBook-Pro.local"
}

variable "ssh_user" {
  default = "ubuntu"
}


variable "name" {
  default = "polkadot"
}

variable "image" {
  default = "ami-0fe3c508bc62c4a7d"
}

variable "bootnode-ports" {
  default = ["30333", "30334"]
}

variable "collator-ports" {
  default = ["9933", "9944"]
}

variable "rpc-ports" {
  default = ["80", "443", "30333", "30334"]
}

variable "metrics-ports" {
  default = ["9100", "9616"]
}