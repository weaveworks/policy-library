package weave.advisor.kustomization_kubeconfig

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value
excluded_clusters := input.parameters.excluded_clusters

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    kubeconfig := controller_spec.kubeConfig
    excluded_clusters[_] == kubeconfig
    result = {
        "issue detected": true,
        "msg": sprintf("The Kustomization '%s' spec.Kubeconfig cannot reference remote cluster from excludedClustersList: %v; found '%s'", [controller_input.metadata.name, excluded_clusters, kubeconfig]),
        "violating_key": "spec.kubeConfig"
    }
}

controller_input = input.review.object

controller_spec = controller_input.spec {
  controller_input.kind == "Kustomization"
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}

isExcludedNamespace = true {
  controller_input.metadata.namespace
  controller_input.metadata.namespace in exclude_namespaces
} else = false
