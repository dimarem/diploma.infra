# monitoring

> **ВАЖНО!** В рамках дипломной работы бюджет ограничен и выделяемые ресурсы для указанных инструментов сильно занижены и не подходят для production-окружений.

## Prometheus

1. Установить:

```bash
helm upgrade --atomic --install prometheus --namespace diploma prometheus
```

2. Получить доступ к интерфейсу:

```bash
kubectl port-forward service/prometheus 9090:9090 -n diploma
```

В браузере перейти по адресу `http://localhost:9090`.

3. Удалить:

```bash
helm uninstall prometheus --namespace diploma
```

## Grafana

1. Установить:

```bash
helm upgrade --atomic --install grafana --namespace diploma grafana
```

2. Получить доступ к интерфейсу:

```bash
kubectl port-forward service/grafana 3000:3000 -n diploma
```

В браузере перейти по адресу `http://localhost:3000`.

**Логин**: admin
**Пароль**: admin

После первого входа изменить пароль.

3. Удалить:

```bash
helm uninstall grafana --namespace diploma
```

## Loki

1. Установить:

```bash
helm upgrade --atomic --install loki --namespace diploma loki
```

2. Удалить:

```bash
helm uninstall loki --namespace diploma
```

## Promtail

1. Установить:

```bash
helm upgrade --atomic --install promtail --namespace diploma promtail
```

2. Удалить:

```bash
helm uninstall promtail --namespace diploma
```
