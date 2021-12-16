# Istio
Istio is a popular service mesh for Kubernetes. 

### Justification


| Name  | Example Scenario  | Outcome |
|---|---|---|
| Ingress access using a virtual service  | When you need need external ingress access to your Kubernetes cluster  | When a virtual service is not set, Istio will not know how to route traffic to the proper pod |



### Istio Documentation

- https://istio.io/latest/docs/reference/config/networking/


## Policies

### destination_rule
TBD

#### Resolution
- https://istio.io/latest/docs/reference/config/networking/destination-rule/

### namespace_label
If you want to set the default behavior of Istio to install a envoy sidecar with every pod in a particual namespace.

#### Resolution
https://istio.io/latest/docs/setup/additional-setup/sidecar-injection/#automatic-sidecar-injection
```
...
metadata:
  name: namespace
  labels: 
    istio-injection: enabled
...
```


### virtual_service
This policy will ensure you are using approved domains

#### Resolution
https://istio.io/latest/docs/reference/config/networking/virtual-service/
```
...
spec:
  hosts:
  - "*.magalix.com"
...
```
