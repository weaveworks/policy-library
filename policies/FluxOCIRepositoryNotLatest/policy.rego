    package weave.advisor.ocirepository_not_latest

    import future.keywords.in

    exclude_namespaces := input.parameters.exclude_namespaces
    exclude_label_key := input.parameters.exclude_label_key
    exclude_label_value := input.parameters.exclude_label_value

    violation[result] {
        isExcludedNamespace == false
        not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
        controller_spec.tag == "latest"
        result = {
            "issue detected": true,
            "msg": sprintf("The OCIRepository '%s' should not use 'latest' as a tag reference.", [controller_input.metadata.name]),
            "violating_key": "spec.tag"
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