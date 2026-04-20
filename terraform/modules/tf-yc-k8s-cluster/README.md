# Модуль кластера Kubernetes

Использует провайдер `yandex-cloud/yandex` версии `>= 0.87.0`.

**Принимает следующие параметры:**

- `cluster_name`. Наименование кластера Kubernetes. Тип `string`.
- `cluster_description`. Описание кластера Kubernetes. Тип `string`.
- `kubernetes_version`. Версия Kubernetes. Тип `string`.
- `min_resource_preset_id`. Класс cpu/memory для master-узла. Тип `string`.
- `network_policy_provider`. Плагин сетевых политик. Тип `string`.
- `service_account_name`. Наименование сервисного аккаунта, который будет управлять кластером Kubernetes. Тип `string`.
- `folder_id`. ID директории в облаке. Тип `string`.
- `kms_key_name`. Наименование KMS-ключа. Тип `string`.
- `network_id`. ID VPC сети. Тип `string`.
- `subnet_id`. ID подсети. Тип `string`.
- `subnet_zone`. Зона подсети. Тип `string`.
