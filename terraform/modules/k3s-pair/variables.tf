variable "target_node"    { type = string }                   # ex: "pve1"
variable "clone_template" { type = string }                   # ex: "ubuntu-22.04-cloudinit"
variable "bridge"         { type = string }
variable "storage"        { type = string }                   # ex: "local-lvm" ou "ceph-ssd"
variable "name_prefix"    { type = string }                   # ex: "k8s-pve1"





