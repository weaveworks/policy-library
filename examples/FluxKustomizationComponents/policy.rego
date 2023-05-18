package weave.advisor.kustomization_components

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value
exclude_components := input.parameters.exclude_components

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    component := controller_spec.components[_]
    component_in_excluded_list(component)
    result = {
        "issue detected": true,
        "msg": sprintf("The Kustomization '%s' spec.components must not include '%s' from the excludedComponentsList", [controller_input.metadata.name, component]),
        "violating_key": "spec.components"
    }
}

component_in_excluded_list(component) {
    exclude_components[_] == component
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
