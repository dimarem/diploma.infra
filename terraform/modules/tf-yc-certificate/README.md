# Модуль для создания сертификата Let's Encrypt

Использует провайдер `yandex-cloud/yandex` версии `>= 0.87.0`.

**Принимает следующие параметры:**

- `cert_name`. Наименование сертификата Let's Encrypt. Тип `string`.
- `cert_domains`. Список доменов сертификата Let's Encrypt. Тип `list`.
- `cert_description`. Сертификат Let's Encrypt для дипломного проекта. Тип `string`.

**Выводит следующую информацию:**

- `certificate_id`: ID созданного сертификата, следует использовать в ingress.secretName.
- `certificate_dns_name`: Наименование поддомена для создания CNAME-записи.
- `certificate_dns_value`: Значение (target) для CNAME-записи.
