variable "image_bucket_name" {
  type        = string
  description = "Наименование бакета для хранения изображений"
}

variable "image_bucket_size" {
  type        = number
  default     = 1073741824
  description = "Размер бакета для хранения изображений в байтах"
}

variable "folder_id" {
  type        = string
  description = "ID директории в облаке"
}
