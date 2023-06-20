package weave.advisor.ocirepository_layer_selector

import future.keywords.in

media_types := input.parameters.media_types
operations := input.parameters.operations
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
    not isExcludedNamespace
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    mediaType := controller_spec.layerSelector.mediaType
    not mediaType in media_types
    result = {
        "issue_detected": true,
        "msg": sprintf("The OCIRepository '%s' has a non-predefined media type. Found: '%s'", [controller_input.metadata.name, mediaType]),
        "violating_key": "spec.layerSelector.mediaType"
    }
}

violation[result] {
    not isExcludedNamespace
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    operation := controller_spec.layerSelector.operation
    not operation in operations
    result = {
        "issue_detected": true,
        "msg": sprintf("The OCIRepository '%s' has a non-predefined operation. Found: '%s'", [controller_input.metadata.name, operation]),
        "violating_key": "spec.layerSelector.operation"
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
