### Run dashboard
```sh
minikube dashboard
```

### Sync charts
```sh
helmfile sync
```

### Open ports (might require root permissions)
```sh
minikube tunnel --cleanup
```

### Access muffin-wallet: `https://wallet.example.com/swagger-ui/index.html`

### Open kiali mesh visualization
```sh
kubectl port-forward svc/kiali 20001:20001 -n istio-system
```
