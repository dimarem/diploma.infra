# Дипломная работа: инфраструктурный репозиторий

## Развернуть инфраструктуру

1. Применить манифесты из terraform.
2. Установить Application Load Balancer.
3. Выполнить инструкции из momo-store-charts.
4. Применить helm-чарт из argocd-charts.
5. Применить helm-чарты из monitoring-tools.
6. Зарегистрировать домен.

Подробности смотри в каждой из указанных директорий и инструкциях ниже.

---

## Развертывание приложения

Состоит из двух этапов:

1. Подготовка и публикация артефактов сборки и helm-чартов в проекте приложения.
2. Запуск пайплайна в текущем проекте.

---

## Скриншоты

В директории screenshots выложены скрины работы приложений.

---

## Application Load Balancer

Для маршрутизации трафика используется Application Load Balancer. Для его установки в кластер Kubernetes необходимо выполнить следующие шаги:

1. [Установить утилиту yc](https://yandex.cloud/ru/docs/cli/quickstart).

2. [Создать сервисный аккаунт](https://cloud.yandex.ru/docs/iam/operations/sa/create), необходимый для работы Ingress-контроллера.

3. [Назначить ему роли](https://cloud.yandex.ru/docs/iam/operations/sa/assign-role-for-sa):

- `alb.editor` — для создания необходимых ресурсов.
- `vpc.publicAdmin` — для управления внешней связностью.
- `certificate-manager.certificates.downloader` — для работы с сертификатами, зарегистрированными в сервисе Yandex Certificate Manager.
- `compute.viewer` — для использования узлов кластера Managed Service for Kubernetes в целевых группах балансировщика.

4. Для установки `ALB Ingress Controller` перейти в консоли управления на вкладку **Marketplace**. Найти в поиске **ALB Ingress Controller**.

5. Заполнить параметры:

- Создать новое пространство имён для установки в него `ALB Ingress Controller`, например `alb-ingress`.
- Создать новый ключ для сервисного аккаунта, созданного в пункте 1.
- Установить приложение.

---

## Регистрация домена


Домен momostore-std-046-13.ru регистрируется в [Reg.ru](https://www.reg.ru/).

Для выпуска сертификатов используется сервис [Yandex Certificate Manager](https://yandex.cloud/ru/docs/certificate-manager/).

DNS не делегирован Yandex. Необходимо выполнить следующие шаги:

1. Получить следующие данные выполнив команду `terraform apply`:

- certificate_id
- certificate_dns_name
- certificate_dns_value

Или командой `terraform show` в блоке yandex_cm_certificate:

- dns_name (certificate_dns_name)
- dns_value ()
- id (certificate_id)

2. Полученный `certificate_id` использовать в манифесте создания ingress:

```yml
ingress:
  secretName: yc-certmgr-cert-id-<certificate_id>
```

3. Перейти в панель управления Reg.ru, затем в **"DNS-серверы и управление зоной"**, нажать **"Изменить"**.
4. В разделе **"Ресурсные записи"** добавить две записи:

- **для основного домена:** `тип записи` - **A**, `subdomain` - **@**, `IP Address` - **адрес ingress-контроллера**.
- **для технического домена (HTTPS):** `тип записи` - **CNAME**, `subdomain` - **_acme-challenge**, `IP Address` - **dns_value (например, "fpqu3rctnmtkbja010e9.cm.yandexcloud.net.")**.
