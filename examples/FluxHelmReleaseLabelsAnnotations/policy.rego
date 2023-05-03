package weave.advisor.helm_release_labels_annotations

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value
required_labels := input.parameters.required_labels
required_annotations := input.parameters.required_annotations

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    label := required_labels[_]
    not controller_input.metadata.labels[label.key] == label.value
    result = {
        "issue detected": true,
        "msg": sprintf("The HelmRelease '%s' must have the label '%s' with value '%s'", [controller_input.metadata.name, label.key, label.value]),
        "violating_key": sprintf("metadata.labels.%s", [label.key])
    }
}

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    annotation := required_annotations[_]
    not controller_input.metadata.annotations[annotation.key] == annotation.value
    result = {
        "issue detected": true,
        "msg": sprintf("The HelmRelease '%s' must have the annotation '%s' with value '%s'", [controller_input.metadata.name, annotation.key, annotation.value]),
        "violating_key": sprintf("metadata.annotations.%s", [annotation.key])
    }
}

# Controller input
controller_input = input.review.object

contains_kind(kind, kinds) {
kinds[_] = kind
}

isExcludedNamespace = true {
  controller_input.metadata.namespace
  controller_input.metadata.namespace in exclude_namespaces
} else = false