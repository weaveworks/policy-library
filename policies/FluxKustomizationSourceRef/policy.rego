package weave.advisor.kustomization_source_ref_kind

import future.keywords.in

allowed_kinds := {"GitRepository", "OCIRepository", "Bucket"}
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == kustomization_input.metadata.labels[exclude_label_key]
    not kustomization_input.spec.sourceRef.kind in allowed_kinds
    result = {
        "issue_detected": true,
        "msg": sprintf("The 'sourceRef.kind' field in the 'spec' section of a Kustomization object can only be one of 'GitRepository', 'OCIRepository' or 'Bucket', but found '%s'", [kustomization_input.spec.sourceRef.kind]),
        "violating_key": "spec.sourceRef.kind"
    }
}

kustomization_input = input.review.object {
  input.review.object.kind == "Kustomization"
}

contains_kind(kind, kinds) {
    kinds[_] = kind
}

isExcludedNamespace = true {
    kustomization_input.metadata.namespace
    kustomization_input.metadata.namespace in exclude_namespaces
} else = false
