# Good Practices Policies

Good Practices Policies are created to bundle individual policies to create solutions according to well known practices 
to provide a baseline security for any weave gitops or kubernetes environment. 

## Getting Started

1. Select the policies to use from [Available Good Practices Policies](#available-good-practices-policies)
2. Add them via Kustomization to your environment.

An example for deploying RBAC Secrets good practices could be: 

```yaml
apiVersion: source.toolkit.fluxcd.io/v1
kind: GitRepository
metadata:
  name: policy-library
  namespace: flux-system
spec:
  interval: 10m0s
  url: https://github.com/weaveworks/policy-library.git
---
apiVersion: kustomize.toolkit.fluxcd.io/v1b
kind: Kustomization
metadata:
  name: rbac-secrets-good-practices
  namespace: flux-system
spec:
  interval: 1m0s
  sourceRef:
    kind: GitRepository
    name: flux-system
  path: ./goodpractices/kubernetes/rbac/secrets
  prune: true
```

## Available Good Practices Policies

- RBAC Secrets: set of policies to harden your Kubernetes Secrets security context according to [Kubernetes Secrets Good Practices](https://kubernetes.io/docs/concepts/security/secrets-good-practices/) 
and [Kubernetes RBAC Good Practices](https://kubernetes.io/docs/concepts/security/rbac-good-practices) 
