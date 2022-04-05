package weave.advisor.network.allow.egress.to.coredns

namespace := input.parameters.namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_label_value == np_input.metadata.labels[exclude_label_key]
  namespace == np_input.metadata.namespace
  some i, j, k
  egress := np_input.spec.egress[i]
  ports := egress.ports[j]
  ports.protocol == "UDP"
  ports.port = 53
  to := egress.to[k]
  to_key := to.podSelector.matchLabels
  not has_key(to_key, "k8s-app")
  result = {
    "issue_detected": true,
    "msg": sprintf("Expecting key 'k8s-app', but '%v' was detected", [to_key]),
    "violating_key": sprintf("spec.egress[%v].to[%v].podSelector.matchLabels", [i,k])
  }
}

violation[result] {
  not exclude_label_value == np_input.metadata.labels[exclude_label_key]
  namespace == np_input.metadata.namespace
  some i, j, k
  egress := np_input.spec.egress[i]
  ports := egress.ports[j]
  ports.protocol == "UDP"
  ports.port = 53
  to := egress.to[k]
  to_value := to.podSelector.matchLabels["k8s-app"]
  not "kube-dns" == to_value
  result = {
    "issue_detected": true,
    "msg": sprintf("Expecting value 'kube-dns', but '%v' was detected", [to_value]),
    "violating_key": sprintf("spec.egress[%v].to[%v].podSelector.matchLabels.k8s-app", [i,k]),
    "recommended_value": "kube-dns"
  }
}

has_key(x, k) { 
  type_name(x[k])
}

np_input = input.review.object {
  contains_kind(input.review.object.kind, {"NetworkPolicy"})
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}