variable "vpc_network_name" {
  type        = string
  description = "Наименование сети, в которой будет расположен кластер Kubernetes"
}

variable "vpc_network_description" {
  type        = string
  description = "Описание сети, в которой будет расположен кластер Kubernetes"
}

variable "vpc_subnet_name" {
  type        = string
  description = "Наименование подсети сети, в которой будет расположен кластер Kubernetes"
}

variable "vpc_subnet_description" {
  type        = string
  description = "Описание подсети, в которой будет расположен кластер Kubernetes"
}

variable "zone" {
  type        = string
  description = "Зона доступности"

  validation {
    condition     = contains(["ru-central1-a", "ru-central1-b", "ru-central1-d"], var.zone)
    error_message = "Недопустимое значение зоны"
  }
}

variable "cidr_blocks" {
  type        = list
  description = "IP и маска адрес подсети"
}
