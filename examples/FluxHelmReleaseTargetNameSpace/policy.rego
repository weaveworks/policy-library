package weave.advisor.helm_release_target_namespace

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value
target_namespaces := input.parameters.target_namespaces

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    not controller_spec.targetNamespace in target_namespaces
    result = {
        "issue_detected": true,
        "msg": sprintf("The HelmRelease '%s' targetNamespace must be one of the allowed target namespaces: %v; found '%s'", [controller_input.metadata.name, target_namespaces, controller_spec.targetNamespace]),
        "violating_key": "spec.targetNamespace"
    }
}

# Controller input
controller_input = input.review.object

# controller_container acts as an iterator to get containers from the template
controller_spec = controller_input.spec {
  controller_input.kind == "HelmRelease"
}

contains_kind(kind, kinds) {
kinds[_] = kind
}

isExcludedNamespace = true {
  controller_input.metadata.namespace
  controller_input.metadata.namespace in exclude_namespaces
} else = false
