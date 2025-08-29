terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc03"     
    }
    vault = {
      source  = "hashicorp/vault"
      version = ">= 3.0.0"
  }

  }
}

 provider "vault" {
    address = "http://127.0.0.1:8200"
    skip_child_token = true

    auth_login {
      path   = "auth/approle/login"

      parameters = {
        role_id   = "51cbf965-9ada-7b7d-fd7a-f6ed9a7b09b2"
        secret_id = "55ff3d3c-f074-4620-7193-f773b89288ac"
      }
    }
  }

data "vault_kv_secret_v2" "terraform_secrets" {
  mount = "kv"         # c’est le mount point
  name  = "terraform"      # c’est le chemin logique (après /data/)
}


provider "proxmox" {
  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = data.vault_kv_secret_v2.terraform_secrets.data.token_id
  pm_api_token_secret = data.vault_kv_secret_v2.terraform_secrets.data.token_secret
  pm_tls_insecure     = false
}

module "pairs" {
  source = "./modules/k3s-pair"

  for_each = var.nodes

  target_node    = each.value.target_node
  name_prefix    = each.value.name_prefix
  clone_template = each.value.clone_template
  storage        = var.storage
  bridge         = var.bridge



}

output "vms" {
  value = {
    for k, m in module.pairs : k => {
      master = m.master
      worker = m.worker
    }
  }
}
