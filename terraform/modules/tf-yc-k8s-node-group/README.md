# Модуль группы узлов

Использует провайдер `yandex-cloud/yandex` версии `>= 0.87.0`.

**Принимает следующие параметры:**

- `node_group_name`. Наименование группы узлов кластера Kubernetes. Тип `string`.
- `node_group_description`. Описание группы узлов кластера Kubernetes. Тип `string`.
- `kubernetes_version`. Версия Kubernetes. Тип `string`.
- `platform_id`. ID платформы узла группы. Тип `string`.
- `node_core_num`. Количество ядер на узле группы. Тип `number`.
- `node_memory_size`. Объем оперативной памяти на узле группы. Тип `number`.
- `boot_disk_type`. Тип загрузочного диска. Тип `string`.
- `boot_disk_size`. Размер загрузочного диска. Тип `number`.
- `node_num`. Количество узлов в группе. Тип `number`. Значение по умолчанию: `1`.
- `zone`. Зона доступности. Тип `string`. Допустимые значения: `ru-central1-a`, `ru-central1-b`, `ru-central1-d`.
- `cluster_id`. ID Kubernetes кластера. Тип `string`.
- `subnet_id`. ID подсети для узлов. Тип `string`.
- `ssh_keys`. Содержание файла ssh-keys. Тип `string`.
