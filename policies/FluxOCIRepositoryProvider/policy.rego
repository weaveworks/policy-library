package weave.advisor.ocirepository_provider

import future.keywords.in

allowed_providers := {"AWS", "Azure", "GCP", "Generic"}
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    not controller_spec.provider in allowed_providers
    result = {
        "issue detected": true,
        "msg": sprintf("The OCIRepository '%s' spec.provider must be one of %v; found '%s'", [controller_input.metadata.name, allowed_providers, controller_spec.provider]),
        "violating_key": "spec.provider"
    }
}

controller_input = input.review.object

controller_spec = controller_input.spec {
  controller_input.kind == "OCIRepository"
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}

isExcludedNamespace = true {
    controller_input.metadata.namespace
    controller_input.metadata.namespace in exclude_namespaces
} else = false
