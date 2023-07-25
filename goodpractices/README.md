# Good Practices Policies

Good Practices Policies are created to bundle individual policies to create solutions according to well known practices 
to provide a baseline security for any weave gitops or kubernetes environment. 

## Getting Started

1. Select the policies to use from [Available Good Practices Policies](#available-good-practices-policies).
2. Add them via Kustomization to your environment.

An example for deploying RBAC Secrets good practices using this GitRepository as a source is shown below.

```yaml
apiVersion: source.toolkit.fluxcd.io/v1
kind: GitRepository
metadata:
  name: policy-library
spec:
  interval: 10m0s
  url: https://github.com/weaveworks/policy-library.git
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: rbac-secrets-good-practices
spec:
  interval: 1m0s
  sourceRef:
    kind: GitRepository
    name: policy-library
  path: ./goodpractices/kubernetes/rbac/secrets
  prune: true
```

In case that you have your own custom Policy Library, add these policies and deploy as usual.


## Available Good Practices Policies

- RBAC Secrets: set of policies to harden your Kubernetes Secrets security context according to [Kubernetes Secrets Good Practices](https://kubernetes.io/docs/concepts/security/secrets-good-practices/) 
and [Kubernetes RBAC Good Practices](https://kubernetes.io/docs/concepts/security/rbac-good-practices) 
