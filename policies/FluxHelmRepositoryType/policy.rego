package weave.advisor.helm_repo_type

import future.keywords.in


exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
    isExcludedNamespace == false
    repository_type := controller_spec.type
    repository_type != "oci"
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    result = {
        "issue detected": true,
        "msg": sprintf("The HelmRepository type must be oci; found '%s'", [repository_type]),
        "recommended_value": "oci",
        "violating_key": "spec.type"
    }
}

# Controller input
controller_input = input.review.object

# controller_container acts as an iterator to get containers from the template
controller_spec = controller_input.spec {
  controller_input.kind == "HelmRepository"
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}

isExcludedNamespace = true {
  controller_input.metadata.namespace
  controller_input.metadata.namespace in exclude_namespaces
} else = false
