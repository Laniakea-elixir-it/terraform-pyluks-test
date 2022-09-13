variable "image" {
  default = "Ubuntu 18.04 - GARR"
}

variable "flavor" {
  default = "c1.tiny"
}

variable "keypair" {
  default = "laniakea-robot"
}

variable "secgroups" {
  default = ["default", "nfs"]
}

variable "pool" {
  default = "floating-ip"
}

variable "network_name" {
  default = "default"
}

variable "volume_name" {
  default = "pyluks-test-vdb"
}

variable "device" {
  default = "/dev/vdb"
}

variable "volume_size" {
  default = 1
}
