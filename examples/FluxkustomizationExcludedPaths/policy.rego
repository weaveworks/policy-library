package weave.advisor.kustomization_excluded_paths

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value
excluded_paths := input.parameters.excluded_paths

violation[result] {
    isExcludedNamespace == false
    path := controller_spec.path
    path in excluded_paths
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    result = {
        "issue detected": true,
        "msg": sprintf("The Kustomization '%s' spec.path '%s' is not allowed.", [controller_input.metadata.name, path]),
        "violating_key": "spec.path",
        "recommended_action": "Update the spec.path to a value not in the excluded paths list."
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
