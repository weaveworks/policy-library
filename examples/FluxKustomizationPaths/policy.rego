package weave.advisor.kustomization_excluded_paths

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value
exclude_paths := input.parameters.exclude_paths

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    path := controller_spec.path
    path in exclude_paths
    result = {
        "issue_detected": true,
        "msg": sprintf("The Kustomization '%s' spec.path '%s' is not allowed.", [controller_input.metadata.name, path]),
        "violating_key": "spec.path"
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
