resource "yandex_vpc_network" "k8s-cluster-network" {
  name        = var.vpc_network_name
  description = var.vpc_network_description
}

resource "yandex_vpc_subnet" "k8s-cluster-subnet" {
  name           = var.vpc_subnet_name
  v4_cidr_blocks = var.cidr_blocks
  zone           = var.zone
  network_id     = yandex_vpc_network.k8s-cluster-network.id
  description    = var.vpc_subnet_description
}
