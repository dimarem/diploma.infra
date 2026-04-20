# Helm-чарты для развертывания backend и frontend

## Получить учетные данные для скачивания образов

Для того, чтобы под в Kubernetes мог скачать образ из репозитория Gitlab, необходимо предоставить ему доступ следующим образом:

1. Перейти в GitLab: `Settings → Access Tokens`.
2. Нажать `Add new token`.
3. Роль: `Developer`.
4. Задать имя, срок и выбрать права: `read_registry`, `write_registry`, `api`.
5. Скопировать токен сразу после создания (позже он будет недоступен).
6. Выполнить следующую команду:

```bash
kubectl create secret docker-registry <имя_секрета> \
  --docker-server=gitlab.praktikum-services.ru:5050 \
  --docker-username=<имя_токена> \
  --docker-password=<сам_токен> \
  --dry-run=client -o yaml
```

7. Из полученного YAML взять значение из поля .dockerconfigjson и поместить его в переменную окружения DOCKER_CONFIG Gitlab.

## Получить идентификатор подсети

Для получения идентификатора `subnets` выполнить команду:

```bash
yc managed-kubernetes cluster list-node-groups \
  --name <cluster_name> \
  --format json | jq '.[].node_template.network_interface_specs[].subnet_ids[]'
```

Полученное значение необходимо указать в файле `values.yaml` в поле `frontend.ingress.subnets`.

## Получить идентификатор сертификата из `Certificate Manager`

В файле `values.yaml` в поле `frontend.ingress.secretName` выставить идентификатор сертификата из сервиса `Yandex Certificate Manager`. Это значение можно получить сразу после применения terraform-манифестов.
