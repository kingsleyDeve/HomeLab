output "master" {
  value = {
    name = proxmox_vm_qemu.master.name
    id   = proxmox_vm_qemu.master.vmid
  }
}

output "worker" {
  value = {
    name = proxmox_vm_qemu.worker.name
    id   = proxmox_vm_qemu.worker.vmid
  }
}
