resource "yandex_cm_certificate" "le-certificate" {
  name    = var.cert_name
  domains = var.cert_domains
  description = var.cert_description

  managed {
    challenge_type = "DNS_CNAME"
  }
}
