variable "private-ports" {
  default = ["9933", "9944"]
}

variable "public-ports" {
    default = ["80","443","30333","30334"]
}

variable "metrics-ports" {
    default = ["9100","9616"]
}