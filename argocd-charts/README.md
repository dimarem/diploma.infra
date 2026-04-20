# ArgoCD

Используется для автоматической синхронизации состояния кластера Kubernetes с конфигурацией приложения в Git-репозитории.

## Общий порядок работы

1. Установить CLI ArgoCD:

```bash
curl -sLO https://github.com/argoproj/argo-workflows/releases/download/v3.5.4/argo-linux-amd64.gz
gunzip argo-linux-amd64.gz
chmod +x argo-linux-amd64
sudo mv ./argo-linux-amd64 /usr/local/bin/argocd
```

2. Проверить установку:

```bash
argocd version
```

3. Добавить репозиторий ArgoCD:

```bash
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
```

5. Установить ArgoCD в кластер Kubernetes:

```bash
cd argocd-charts
helm install argocd argo/argo-cd \
  -n argocd \
  --create-namespace \
  -f values.yaml
```

6. Проверить потребление ресурсов (опционально):

```bash
kubectl top pods -n argocd
```

7. Получить пароль администратора:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo
```

8. Получить доступ к панели управления:

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

В браузере перейти по адресу `https://localhost:8080`.

**Логин**: admin
**Пароль**: пароль, полученный на шаге 7.

9. Авторизоваться:

```bash
argocd login localhost:8080 --insecure
```

10. Дать ArgoCD доступ к Nexus, в котором хранятся helm-чарты проекта:

```bash
argocd repo add https://nexus.praktikum-services.tech/repository/std-046-13-diploma-helm-front/ \
  --type helm \
  --username std-046-13 \
  --password <nexus_password> \
  --name std-046-13-diploma-helm-front

argocd repo add https://nexus.praktikum-services.tech/repository/std-046-13-diploma-helm-back/ \
  --type helm \
  --username std-046-13 \
  --password <nexus_password> \
  --name std-046-13-diploma-helm-back
```

**Проверить добавление:**

```bash
argocd repo list
```

**Если потребуется удалить репозиторий:**

```bash
argocd repo rm https://nexus.praktikum-services.tech/repository/<repo_name>/
```

11. Создать приложения, выполнив команды ниже:

```bash
argocd app create frontend \
  --repo https://nexus.praktikum-services.tech/repository/std-046-13-diploma-helm-front/ \
  --helm-chart frontend-momo-store-chart \
  --revision "*" \
  --dest-namespace diploma \
  --dest-server https://kubernetes.default.svc \
  --sync-policy automated \
  --auto-prune \
  --self-heal

argocd app create backend \
  --repo https://nexus.praktikum-services.tech/repository/std-046-13-diploma-helm-back/ \
  --helm-chart backend-momo-store-chart \
  --revision "*" \
  --dest-namespace diploma \
  --dest-server https://kubernetes.default.svc \
  --sync-policy automated \
  --auto-prune \
  --self-heal
```

12. (Опционально) Если домен для кластера не установлен, можно получить IP-адрес ingress'а следующей командой:

```bash
kubectl get ingress -n diploma
# NAME                         CLASS    HOSTS                     ADDRESS   PORTS     AGE
# argocd-diploma-alb-ingress   <none>   momostore-std-046-13.ru             80, 443   2m32s
```

Добавить в /etc/hosts запись:

```
<ADDRESS> momostore-std-046-13.ru
```

Перейти в браузере по адресу `http://momostore-std-046-13.ru`.
