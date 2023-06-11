package weave.advisor.helm_release_remediation_retries

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value
lower_bound := input.parameters.lower_bound
upper_bound := input.parameters.upper_bound

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    remediation_retries := get_remediation_retries(controller_spec)
    remediation_retries < lower_bound
    result = {
        "issue detected": true,
        "msg": sprintf("The HelmRelease '%s' remediation retries must be between %d and %d; found %d", [controller_input.metadata.name, lower_bound, upper_bound, remediation_retries]),
        "violating_key": "spec.install.remediation.retries/spec.update.remediation.retries"
    }
}

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    remediation_retries := get_remediation_retries(controller_spec)
    remediation_retries > upper_bound
    result = {
        "issue detected": true,
        "msg": sprintf("The HelmRelease '%s' remediation retries must be between %d and %d; found %d", [controller_input.metadata.name, lower_bound, upper_bound, remediation_retries]),
        "violating_key": "spec.install.remediation.retries/spec.update.remediation.retries"
    }
}

# Controller input
controller_input = input.review.object

# controller_container acts as an iterator to get containers from the template
controller_spec = controller_input.spec {
    controller_input.kind == "HelmRelease"
}

get_remediation_retries(controller_spec) = controller_spec.install.remediation.retries {
    not is_null(controller_spec.install)
    not is_null(controller_spec.install.remediation)
    not is_null(controller_spec.install.remediation.retries)
} else = controller_spec.update.remediation.retries {
    not is_null(controller_spec.update)
    not is_null(controller_spec.update.remediation)
    not is_null(controller_spec.update.remediation.retries)
}

contains_kind(kind, kinds) {
    kinds[_] = kind
}

isExcludedNamespace = true {
    controller_input.metadata.namespace
    controller_input.metadata.namespace in exclude_namespaces
} else = false
