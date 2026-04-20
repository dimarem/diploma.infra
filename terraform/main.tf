module "network" {
  source                  = "./modules/tf-yc-network"
  vpc_network_name        = var.vpc_network_name
  vpc_network_description = var.vpc_network_description
  vpc_subnet_name         = var.vpc_subnet_name
  vpc_subnet_description  = var.vpc_subnet_description
  zone                    = var.zone
  cidr_blocks             = var.cidr_blocks
}

module "cluster" {
  source                  = "./modules/tf-yc-k8s-cluster"
  cluster_name            = var.cluster_name
  cluster_description     = var.cluster_description
  kubernetes_version      = var.kubernetes_version
  min_resource_preset_id  = var.min_resource_preset_id
  network_policy_provider = var.network_policy_provider
  service_account_name    = var.service_account_name
  folder_id               = var.folder_id
  kms_key_name            = var.kms_key_name
  network_id              = module.network.network_id
  subnet_id               = module.network.subnet_id
  subnet_zone             = module.network.subnet_zone
}

module "node-group" {
  source                 = "./modules/tf-yc-k8s-node-group"
  node_group_name        = var.node_group_name
  node_group_description = var.node_group_description
  kubernetes_version     = var.kubernetes_version
  platform_id            = var.platform_id
  node_core_num          = var.node_core_num
  node_memory_size       = var.node_memory_size
  boot_disk_type         = var.boot_disk_type
  boot_disk_size         = var.boot_disk_size
  node_num               = var.node_num
  zone                   = var.zone
  cluster_id             = module.cluster.cluster_id
  subnet_id              = module.network.subnet_id
  ssh_keys               = file("./ssh-keys")
}

module "certificate" {
  source           = "./modules/tf-yc-certificate"
  cert_name        = var.cert_name
  cert_domains     = var.cert_domains
  cert_description = var.cert_description
}

module "image-bucket" {
  source            = "./modules/tf-yc-image-bucket"
  image_bucket_name = var.image_bucket_name
  folder_id         = var.folder_id
  image_bucket_size = var.image_bucket_size
}
