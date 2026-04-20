# kubernetes

Содержит манифесты Kubernetes для развертывания backend и frontend приложения. **Для развертиывания кластера не используются, только для демонстрации.**

В файлах `secrets.yaml` опущено значение для ключа `.dockerconfigjson`, его необходимо сформировать для своего Gitlab-репозитория отдельно согласно инструкции ниже.

**Развернуть backend:**

```bash
kubectl apply -f backend/namespace.yaml
kubectl apply -f backend/secrets.yaml
kubectl apply -f backend/deployment.yaml
kubectl apply -f backend/hpa.yaml
kubectl apply -f backend/service.yaml
```

**Развернуть frontend:**

```bash
kubectl apply -f frontend/namespace.yaml
kubectl apply -f frontend/secrets.yaml
kubectl apply -f frontend/deployment.yaml
kubectl apply -f frontend/service.yaml
kubectl apply -f frontend/ingress.yaml
```

**Вывести список ресурсов кластера:**

```bash
kubectl get all -n diploma
kubectl get ingress -n diploma
```

**Удалить backend:**

```bash
kubectl delete -f backend/secrets.yaml
kubectl delete -f backend/deployment.yaml
kubectl delete -f backend/hpa.yaml
kubectl delete -f backend/service.yaml
kubectl delete -f backend/namespace.yaml
```

**Удалить frontend:**

```bash
kubectl delete -f frontend/secrets.yaml
kubectl delete -f frontend/deployment.yaml
kubectl delete -f frontend/ingress.yaml
kubectl delete -f frontend/service.yaml
kubectl delete -f frontend/namespace.yaml
```
