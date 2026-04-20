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

variable "folder_id" {
  type        = string
  description = "ID директории в облаке"
}

variable "kms_key_name" {
  type        = string
  description = "Наименование KMS-ключа"
}

variable "network_id" {
  type        = string
  description = "ID VPC сети"
}

variable "subnet_id" {
  type        = string
  description = "ID подсети"
}

variable "subnet_zone" {
  type        = string
  description = "Зона подсети"
}
