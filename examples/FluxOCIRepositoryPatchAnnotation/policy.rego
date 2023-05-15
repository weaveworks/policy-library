package weave.advisor.ocirepository_patch_annotation

import future.keywords.in

provider := input.parameters.provider
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_meta.labels[exclude_label_key]
    patch_annotation := controller_meta.annotations["fluxcd.io/automated"]
    patch_annotation != provider
    result = {
        "issue detected": true,
        "msg": sprintf("The OCIRepository '%s' must have a patch annotation that matches the provider '%s'. Found: '%s'", [controller_input.metadata.name, provider, patch_annotation]),
        "violating_key": "metadata.annotations.fluxcd.io/automated"
    }
}

controller_input = input.review.object

controller_meta = controller_input.metadata {
    controller_input.kind == "OCIRepository"
}


contains_kind(kind, kinds) {
    kinds[_] = kind
}

isExcludedNamespace = true {
    controller_meta.namespace
    controller_meta.namespace in exclude_namespaces
} else = false