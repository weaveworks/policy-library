package weave.advisor.kustomization_decryption_provider

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value
decryption_providers := input.parameters.decryption_providers

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    provider := controller_spec.decryption.provider
    not valid_provider(provider)
    result = {
        "issue detected": true,
        "msg": sprintf("The Kustomization '%s' Spec.decryption.provider must be set to one of %v; found '%s'", [controller_input.metadata.name, decryption_providers, provider]),
        "violating_key": "spec.decryption.provider"
    }
}

valid_provider(provider) {
    decryption_providers[_] == provider
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
