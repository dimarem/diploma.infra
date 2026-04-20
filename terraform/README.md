# terraform

Содержит манифесты Terraform для развертывания кластера Kubernetes.

При использовании Terraform следует руководствоваться следующими источниками информации:

- [Создание сервисного аккаунта](https://yandex.cloud/ru/docs/iam/operations/sa/create)
- [Источники данных Terraform](https://yandex.cloud/ru/docs/terraform/tutorials/terraform-data-sources)
- [Создание кластера Managed Service for Kubernetes](https://yandex.cloud/ru/docs/managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create)
- [Взаимосвязь ресурсов в Managed Service for Kubernetes](https://yandex.cloud/ru/docs/managed-kubernetes/concepts/)
- [Создание группы узлов](https://yandex.cloud/ru/docs/managed-kubernetes/operations/node-group/node-group-create)
- [Настройка контроллера сетевых политик Calico](https://yandex.cloud/ru/docs/managed-kubernetes/operations/calico)
- [Подключение к узлу по SSH](https://yandex.cloud/ru/docs/managed-kubernetes/operations/node-connect-ssh)
- [Yandex Certificate Manager](https://yandex.cloud/ru/docs/certificate-manager/)
- [Yandex Object Storage](https://yandex.cloud/ru/docs/storage/)
- [yandex_kubernetes_cluster](https://yandex.cloud/ru/docs/terraform/resources/kubernetes_cluster)
- [yandex_vpc_network](https://yandex.cloud/ru/docs/terraform/resources/vpc_network)
- [yandex_vpc_subnet](https://yandex.cloud/ru/docs/terraform/resources/vpc_subnet)
- [yandex_iam_service_account](https://yandex.cloud/ru/docs/terraform/resources/iam_service_account)
- [yandex_resourcemanager_folder_iam_member](https://yandex.cloud/ru/docs/terraform/resources/resourcemanager_folder_iam_member)
- [yandex_kms_symmetric_key](https://yandex.cloud/ru/docs/terraform/resources/kms_symmetric_key)
- [yandex_kubernetes_node_group](https://yandex.cloud/ru/docs/terraform/resources/kubernetes_node_group)
- [yandex_cm_certificate](https://yandex.cloud/ru/docs/terraform/resources/cm_certificate)
- [yandex_storage_bucket](https://yandex.cloud/ru/docs/terraform/resources/storage_bucket)

## Использование terraform-манифестов

1. Установить [terraform CLI](https://www.terraform.io/downloads).
2. Установить интерфейс командной строки Yandex Cloud (CLI):

```bash
curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
```

3. Используя созданный сервисный аккаунт, добавить аутентификационные данные в переменные окружения:

```bash
export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)
```

4. Используя созданный сервисный аккаунт, сгенерировать ключи доступа к S3 (можно сохранить для последующего использования):

```bash
yc iam access-key create --service-account-name <имя_сервисного_аккаунта>
```

Полученные значения передать в переменные среды.

```bash
export AWS_ACCESS_KEY_ID=<идентификатор статического ключа>
export AWS_SECRET_ACCESS_KEY=<секретный ключ>
```

5. Настроить провайдер:

```bash
mv ~/.terraformrc ~/.terraformrc.old
nano ~/.terraformrc
```

Добавить следующий блок:

```
provider_installation {
  network_mirror {
    url = "https://terraform-mirror.yandexcloud.net/"
    include = ["registry.terraform.io/*/*"]
  }
  direct {
    exclude = ["registry.terraform.io/*/*"]
  }
}
```

6. В корне директории создать файл terraform.tfvars со следующим содержанием:

```
# наименование кластера Kubernetes
cluster_name             = "diploma-k8s-cluster"

# описание кластера Kubernetes
cluster_description      = "Kubernetes кластер дипломного проекта"

# версия Kubernetes
kubernetes_version       = "1.33"

# 4 ядра, 16Гб RAM на узел
min_resource_preset_id   = "s-c4-m16"

# сетевой плагин
network_policy_provider  = "CALICO"

# сервисный аккаунт для управления кластером Kubernetes
service_account_name     = "<account_name>"

# ID облака
cloud_id                 = "<cloud_id>"

# ID директории в облаке
folder_id                = "<folder_id>"

# зона доступности кластера Kubernetes
zone                     = "ru-central1-d"

# наименование ключа шифрования секретов
kms_key_name             = "kms-key"

# наименование группы узлов под управлением кластера Kubernetes
node_group_name          = "diploma-k8s-node-group"

# описание группы узлов под управлением кластера Kubernetes
node_group_description   = "Группа узлов Kubernetes кластера дипломного проекта"

# набор аппаратных и программных характеристик, определяющих доступные конфигурации (CPU, память, диски и т. п.).
platform_id              = "standard-v2"

# кол-во ядер в одном узле
node_core_num            = 4

# кол-во оперативной памяти в одном узле (Гб) 
node_memory_size         = 8

# тип загрузочного диска узла (для экономии ресурсов, рассмотреть ssd)
boot_disk_type           = "network-hdd"

# размер загрузочного диска узла (Гб) 
boot_disk_size           = 64

# кол-во узлов в группе
node_num                 = 1

# наименование сети, в которой будет распологаться кластер Kubernetes
vpc_network_name         = "diploma-k8s-cluster-network"

# описание сети, в которой будет распологаться кластер Kubernetes
vpc_network_description  = "Сеть для кластера Kubernetes дипломного проекта"

# наименование подсети, в которой будет распологаться кластер Kubernetes
vpc_subnet_name          = "diploma-k8s-cluster-subnet"

# описание подсети, в которой будет распологаться кластер Kubernetes
vpc_subnet_description   = "Подсеть для кластера Kubernetes дипломного проекта"

# IPs и маска адрес подсети
cidr_blocks              = ["10.1.0.0/16"]

# наименование сертификата Let's Encrypt
cert_name                = "diploma-momo-store-cert"

# список доменов сертификата Let's Encrypt
cert_domains             = ["momostore-std-046-13.ru"]

# описание сертификата Let's Encrypt
cert_description         = "Сертификат Let's Encrypt для дипломного проекта"

# наименование бакета для хранения изображений
image_bucket_name        = "diploma-image-bucket"

# размер бакета для хранения изображений  в байтах
image_bucket_size        = 1073741824
```

7. В корне директории создать файл `ssh-keys` со следующим содержанием в соответствии с этой [документацией](https://yandex.cloud/ru/docs/managed-kubernetes/operations/node-connect-ssh):

```
# пример
admin:ssh-ed25519 AAAAC3Nza...KkW admin
```

8. Инициализировать рабочую директорию для использования Terraform, если это не было сделано ранее: `terraform init`.
9. (Опционально) Валидировать манифесты: `terraform validate`.
10. (Опционально) Составить план: `terraform plan`.
11. Применить манифесты: `terraform apply`.
12. Получить учетный данные кластера (см. на странице "Обзор" в интерфейсе управления):

```bash
yc managed-kubernetes cluster get-credentials --id catsl... --external
```

13. Удалить кластер: `terraform destroy`.
