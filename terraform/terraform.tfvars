proxmox_api_url      = "https://pve1.homelab.lan:8006/api2/json"

storage        = "local-lvm"
bridge         = "vmbr0"

nodes = {
  pve1-1165 = {
    target_node    = "pve1-1165"
    name_prefix    = "k3s-pve1"

    clone_template = "ubuntu-srv-template"
  }
  pve2-0831 = {
    target_node    = "pve2-0831"
    name_prefix    = "k3s-pve2"
    
    clone_template = "ubuntu-srv-template2"
  }
  pve3-0340 = {
    target_node    = "pve3-0340"
    name_prefix    = "k3s-pve3"

    clone_template = "ubuntu-srv-template3"
  }
}
