terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc03"
    }
  }
}

locals {
  master_name = "${var.name_prefix}-master"
  worker_name = "${var.name_prefix}-worker"
 
}

# MASTER
resource "proxmox_vm_qemu" "master" {
  name        = local.master_name
  target_node = var.target_node
  

  clone     = var.clone_template
  full_clone = true

  agent   = 1
  onboot  = true


  scsihw = "virtio-scsi-pci"

disk {
  type        = "disk"
  passthrough = true
  slot        = "scsi0"
}

  network {
    model  = "virtio"
    bridge = var.bridge
    id     = 0
  }

  os_type = "cloud-init" 
 

}

# WORKER
resource "proxmox_vm_qemu" "worker" {
  name        = local.worker_name
  target_node = var.target_node
  

  clone     = var.clone_template
  full_clone = true

  agent   = 1
  onboot  = true



  

  scsihw = "virtio-scsi-pci"

 disk {
  type        = "disk"
  passthrough = true
  slot        = "scsi0"
}

  network {
    model  = "virtio"
    bridge = var.bridge
    id     = 0
  }

  os_type = "cloud-init"

}
