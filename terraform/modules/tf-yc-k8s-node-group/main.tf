resource "yandex_kubernetes_node_group" "k8s-node-group" {
  name        = var.node_group_name
  cluster_id  = var.cluster_id
  description = var.node_group_description
  version     = var.kubernetes_version
  
  instance_template {
    platform_id = var.platform_id
    network_interface {
      nat        = true
      subnet_ids = [var.subnet_id]
    }
    resources {
      memory = var.node_memory_size
      cores  = var.node_core_num
    }
    boot_disk {
      type = var.boot_disk_type
      size = var.boot_disk_size
    }
    scheduling_policy {
      preemptible = false
    }
    container_runtime {
      type = "containerd"
    }
    metadata = {
      "ssh-keys" = var.ssh_keys
    }
  }
  scale_policy {
    fixed_scale {
      size = var.node_num
    }
  }
  allocation_policy {
    location {
      zone = var.zone
    }
  }
}
