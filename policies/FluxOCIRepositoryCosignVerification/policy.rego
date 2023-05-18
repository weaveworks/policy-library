package weave.advisor.ocirepository_cosign_verification

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    not controller_spec.verify.provider == "cosign"
    not controller_spec.verify.secretRef.name
    result = {
        "issue detected": true,
        "msg": "The OCIRepository must provide cosign verification and reference a secret containing the Cosign public keys of trusted authors in '.tgz' extension",
        "violating_key": "spec.verify"
    }
}

# Controller input
controller_input = input.review.object

# controller_container acts as an iterator to get containers from the template
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
