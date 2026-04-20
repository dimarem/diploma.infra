output "certificate_id" {
  value       = yandex_cm_certificate.le-certificate.id
  description = "ID созданного сертификата, следует использовать в ingress.secretName"
}

output "certificate_dns_name" {
  value       = yandex_cm_certificate.le-certificate.challenges[0].dns_name
  description = "Наименование поддомена для создания CNAME-записи"
}

output "certificate_dns_value" {
  value       = yandex_cm_certificate.le-certificate.challenges[0].dns_value
  description = "Значение (target) для CNAME-записи"
}
