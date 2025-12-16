# Shamaev Onar | PDSA LHW-2

## Задание и как выполнено

> muffin-wallet и muffin-currency должны разворачиваться через helmfile

В репозитории подготовлен helmfile.yaml

---

**Установка Istio**
> Установить Istio в кластер.

Автоматической установки Istio в коде репозитория не предусмотрено - его необходимо установить самостоятельно.
*Я проводил установку Istio-base и Istio-d через Helm*.

> Включить автоматическую инжекцию sidecar-прокси для пространства имён, где развёрнуты микросервисы.

В репозитории подготовлен Helm Chart `./muffin-namespace`, который автоматически создаст требуемый неймспейс с лейблом.

---

**Конфигурация Istio**

**Ingress Gateway:**

> Настроить Istio Ingress Gateway для внешнего доступа к muffin-wallet.

Автоматической установки Istio-Ingress в коде репозитория не предусмотрено - его необходимо установить самостоятельно. *Я проводил установку Istio-Ingress через Helm*.

> Обеспечить маршрутизацию трафика по хосту (например, wallet.example.com).

Helm Chart `./muffin-wallet` содержит подготовленный ресурс `Gateway`.

**Observability:**

> Установить Kiali, Prometheus для визуализации трафика и метрик.

Автоматической установки Kiali и Prometheus в коде репозитория не предусмотрено - их необходимо установить самостоятельно. *Я проводил установку по ресурсам с сайта Istio*.

> Настроить сбор метрик и трассировку запросов между микросервисами.

Это выполняется автоматически Prometeus и Kiali за счет sidecar-прокси.

**Security:**

> Включить mTLS для шифрования трафика между микросервисами.

Helm Charts `./muffin-wallet` и `./muffin-currency` содержит подготовленные ресурсы `DestinationRule` и `PeerAuthentication`.

> Настроить AuthorizationPolicy для ограничения доступа к muffin-currency только с muffin-wallet.

Helm Chart `./muffin-currency` содержит подготовленный ресурс `AuthorizationPolicy`.

**Resilience:**

> Настроить Circuit Breaker и Retry для устойчивости к сбоям.
Реализовать таймауты и лимиты на количество запросов.

Helm Charts `./muffin-wallet` и `./muffin-currency` содержит подготовленные ресурсы `DestinationRule` и `VirtualService`.

**VirtualService, ServiceEntry, Gateway:**

> Создать VirtualService для маршрутизации трафика между muffin-wallet и muffin-currency.

Helm Charts `./muffin-wallet` и `./muffin-currency` содержит подготовленные ресурсы `VirtualService`.

> Взаимодействие с внешней БД через ServiceEntry

Helm Charts `./muffin-wallet` содержит подготовленный ресурс `ServiceEntry`.

## Туториал

*Заранее установить Helm и Helmfile в систему. Установить Istio, Istio-d, Istio-Ingress, Prometheus и Kiali в кластер*. 

*При необходимости поправить селектор-лейбл Istio-Ingress в `values.yaml` Helm Chart `./muffin-wallet`, так как в зависимости от установки Istio он может отличаться.*

Запустить развертывание всего сервис-меша командой (находясь в папке корня репозитория):
```sh
helmfile sync
```

## *Полезные команды для minikube + helm istio*

Поднять дашборд k8s:
```sh
minikube dashboard
```

Открыть LoadBalancer для Istio-Ingress (требует права Администратора)
```sh
minikube tunnel --cleanup
```

Адрес входа в сервис-меш:

`https://wallet.example.com/swagger-ui/index.html`

Поднять дашборд Kiali:
```sh
kubectl port-forward svc/kiali 20001:20001 -n istio-system
```
