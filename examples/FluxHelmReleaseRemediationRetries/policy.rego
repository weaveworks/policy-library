package weave.advisor.helm_release_remediation_retries

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value
lower_bound := input.parameters.lower_bound
upper_bound := input.parameters.upper_bound

# Violation for install remediation retries lower_bound
violation[result] {
    not isExcludedNamespace
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    retries := controller_spec.install.remediation.retries
    not is_null(retries)
    retries < lower_bound
    result = {
        "issue_detected": true,
        "msg": sprintf("The HelmRelease '%s' install remediation retries must be between %d and %d; found %d", [controller_input.metadata.name, lower_bound, upper_bound, retries]),
        "violating_key": "spec.install.remediation.retries"
    }
}

# Violation for install remediation retries upper_bound
violation[result] {
    not isExcludedNamespace
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    retries := controller_spec.install.remediation.retries
    not is_null(retries)
    retries > upper_bound
    result = {
        "issue_detected": true,
        "msg": sprintf("The HelmRelease '%s' install remediation retries must be between %d and %d; found %d", [controller_input.metadata.name, lower_bound, upper_bound, retries]),
        "violating_key": "spec.install.remediation.retries"
    }
}

# Violation for upgrade remediation retries lower_bound
violation[result] {
    not isExcludedNamespace
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    retries := controller_spec.upgrade.remediation.retries
    not is_null(retries)
    retries < lower_bound
    result = {
        "issue_detected": true,
        "msg": sprintf("The HelmRelease '%s' upgrade remediation retries must be between %d and %d; found %d", [controller_input.metadata.name, lower_bound, upper_bound, retries]),
        "violating_key": "spec.upgrade.remediation.retries"
    }
}

# Violation for upgrade remediation retries upper_bound
violation[result] {
    not isExcludedNamespace
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    retries := controller_spec.upgrade.remediation.retries
    not is_null(retries)
    retries > upper_bound
    result = {
        "issue_detected": true,
        "msg": sprintf("The HelmRelease '%s' upgrade remediation retries must be between %d and %d; found %d", [controller_input.metadata.name, lower_bound, upper_bound, retries]),
        "violating_key": "spec.upgrade.remediation.retries"
    }
}

# Controller input
controller_input = input.review.object

controller_spec = controller_input.spec {
    controller_input.kind == "HelmRelease"
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}

isExcludedNamespace = true {
    controller_input.metadata.namespace
    controller_input.metadata.namespace in exclude_namespaces
} else = false
