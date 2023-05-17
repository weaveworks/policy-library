package weave.advisor.ocirepository_ignore_suffixes

import future.keywords.in

suffixes := input.parameters.suffixes
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    ignore := split(controller_spec.ignore, "\n")
    not all_suffixes_present(ignore, suffixes)
    result = {
        "issue detected": true,
        "msg": sprintf("The OCIRepository '%s' must include the required suffixes in the ignore field. Required suffixes: %v", [controller_input.metadata.name, suffixes]),
        "violating_key": "spec.ignore"
    }
}

all_suffixes_present(ignore, suffixes) {
    all_suffixes_count(ignore, suffixes) == count(suffixes)
}

all_suffixes_count(ignore, suffixes) = total {
    total := count({suffix | suffix := suffixes[_]; line := ignore[_]; endswith(line, suffix)})
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
