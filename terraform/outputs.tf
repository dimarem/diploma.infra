output "certificate_id" {
  value       = module.certificate.certificate_id
  description = "ID созданного сертификата, следует использовать в ingress.secretName"
}

output "certificate_dns_name" {
  value       = module.certificate.certificate_dns_name
  description = "Наименование поддомена для создания CNAME-записи"
}

output "certificate_dns_value" {
  value       = module.certificate.certificate_dns_value
  description = "Значение (target) для CNAME-записи"
}
