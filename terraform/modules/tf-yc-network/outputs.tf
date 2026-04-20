output "network_id" {
  description = "ID созданной VPC сети"
  value       = yandex_vpc_network.k8s-cluster-network.id
}

output "subnet_id" {
  description = "ID созданной подсети"
  value       = yandex_vpc_subnet.k8s-cluster-subnet.id
}

output "subnet_zone" {
  description = "Зона подсети"
  value       = yandex_vpc_subnet.k8s-cluster-subnet.zone
}
