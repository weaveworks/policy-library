package weave.advisor.resource_name_regex

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_metadata.labels[exclude_label_key]
    not re_match(`[A-z]{12}-[A-z]{12}`, controller_metadata.name)
    result = {
        "issue detected": true,
        "msg": sprintf("The resource name of kind '%s' must match the regex pattern '[A-z]{12}-[A-z]{12}'; found '%s'", [controller_input.kind, controller_metadata.name]),
        "violating_key": "metadata.name"
    }
}

# Controller input
controller_input = input.review.object

controller_metadata = controller_input.metadata {
  contains_kind(controller_input.kind, ["HelmRelease", "GitRepository", "OCIRepository", "Bucket", "HelmChart", "HelmRepository", "Kustomization"])
}

contains_kind(kind, kinds) {
kinds[_] = kind
}

isExcludedNamespace = true {
  controller_metadata.namespace
  controller_metadata.namespace in exclude_namespaces
} else = false
