variable "cluster_name"  {
  type        = string
  description = "Наименование кластера Kubernetes"
}

variable "cluster_description"  {
  type        = string
  description = "Описание кластера Kubernetes"
}

variable "kubernetes_version"  {
  type        = string
  description = "Версия Kubernetes"
}

variable "min_resource_preset_id"  {
  type        = string
  description = "Класс cpu/memory для master-узла"
}

variable "network_policy_provider"  {
  type        = string
  description = "Плагин сетевых политик"
}

variable "service_account_name"  {
  type        = string
  description = "Наименование сервисного аккаунта, который будет управлять кластером Kubernetes"
}

variable "cloud_id" {
  type        = string
  description = "ID облака"
}

variable "folder_id" {
  type        = string
  description = "ID директории в облаке"
}

variable "zone" {
  type        = string
  description = "Зона доступности"

  validation {
    condition     = contains(["ru-central1-a", "ru-central1-b", "ru-central1-d"], var.zone)
    error_message = "Недопустимое значение зоны"
  }
}

variable "kms_key_name" {
  type        = string
  description = "Наименование KMS-ключа"
}

variable "node_group_name" {
  type        = string
  description = "Наименование группы узлов кластера Kubernetes"
}

variable "node_group_description" {
  type        = string
  description = "Описание группы узлов кластера Kubernetes"
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
  description = "Наименование подсети, в которой будет расположен кластер Kubernetes"
}

variable "vpc_subnet_description" {
  type        = string
  description = "Описание подсети, в которой будет расположен кластер Kubernetes"
}

variable "cidr_blocks" {
  type        = list
  description = "IP и маска адрес подсети"
}

variable "cert_name" {
  type        = string
  description = "Наименование сертификата Let's Encrypt"
}

variable "cert_domains" {
  type        = list
  description = "Список доменов сертификата Let's Encrypt"
}

variable "cert_description" {
  type        = string
  description = "Сертификат Let's Encrypt для дипломного проекта"
}

variable "image_bucket_name" {
  type        = string
  description = "Наименование бакета для хранения изображений"
}

variable "image_bucket_size" {
  type        = number
  default     = 1073741824
  description = "Размер бакета для хранения изображений в байтах"
}
