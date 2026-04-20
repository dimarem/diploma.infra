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
