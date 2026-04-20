# Модуль сети

Использует провайдер `yandex-cloud/yandex` версии `>= 0.87.0`.

**Принимает следующие параметры:**

- `vpc_network_name`. Наименование сети, в которой будет расположен кластер Kubernetes. Тип `string`.
- `vpc_network_description`. Описание сети, в которой будет расположен кластер Kubernetes. Тип `string`.
- `vpc_subnet_name`. Наименование подсети сети, в которой будет расположен кластер Kubernetes. Тип `string`.
- `vpc_subnet_description`. Описание подсети, в которой будет расположен кластер Kubernetes. Тип `string`.
- `zone`. Зона доступности. Тип `string`. Допустимые значения: `ru-central1-a`, `ru-central1-b`, `ru-central1-d`.
- `cidr_blocks`. IP и маска адрес подсети. Тип `list`.

**Выводит следующую информацию:**

- `network_id`: ID созданной VPC сети.
- `subnet_id`: ID созданной подсети.
- `subnet_zone`: Зона подсети.
