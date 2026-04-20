variable "node_group_name" {
  type        = string
  description = "Наименование группы узлов кластера Kubernetes"
}

variable "node_group_description" {
  type        = string
  description = "Описание группы узлов кластера Kubernetes"
}

variable "kubernetes_version"  {
  type        = string
  description = "Версия Kubernetes"
}

variable "platform_id" {
  type        = string
  description = "ID платформы узла группы"
}

variable "node_core_num" {
  type        = number
  description = "Количество ядер на узле группы"
}

variable "node_memory_size" {
  type        = number
  description = "Объем оперативной памяти на узле группы"
}

variable "boot_disk_type" {
  type        = string
  description = "Тип загрузочного диска"
}

variable "boot_disk_size" {
  type        = number
  description = "Размер загрузочного диска"
}

variable "node_num" {
  type        = number
  default     = 1
  description = "Количество узлов в группе"
}

variable "zone" {
  type        = string
  description = "Зона доступности"

  validation {
    condition     = contains(["ru-central1-a", "ru-central1-b", "ru-central1-d"], var.zone)
    error_message = "Недопустимое значение зоны"
  }
}

variable "cluster_id" {
  type        = string
  description = "ID Kubernetes кластера"
}

variable "subnet_id" {
  type        = string
  description = "ID подсети для узлов"
}

variable "ssh_keys" {
  type        = string
  description = "Содержание файла ssh-keys"
}
