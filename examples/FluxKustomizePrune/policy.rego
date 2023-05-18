package weave.advisor.kustomization_prune

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value
prune := input.parameters.prune

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    controller_spec.prune != prune
    result = {
        "issue detected": true,
        "msg": sprintf("The 'spec.prune' field in the Kustomization object must be set to '%v', but found '%v'", [prune, controller_spec.prune]),
        "violating_key": "spec.prune"
    }
}

# Controller input
controller_input = input.review.object

# controller_container acts as an iterator to get containers from the template
controller_spec = controller_input.spec {
  controller_input.kind == "Kustomization"
}

isExcludedNamespace = true {
    controller_input.metadata.namespace
    controller_input.metadata.namespace in exclude_namespaces
} else = false
