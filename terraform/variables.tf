variable "proxmox_api_url"      { type = string }     
variable "storage"        { type = string }       
variable "bridge"         { type = string}

variable "nodes" {
  type = map(object({
    target_node     : string
    name_prefix     : string
    clone_template  : string
  }))
}
