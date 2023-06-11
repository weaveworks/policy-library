package weave.advisor.resource_reconcile_interval

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value
lower_bound := input.parameters.lower_bound
upper_bound := input.parameters.upper_bound

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    reconcile_interval := parse_interval(controller_spec.interval)
    reconcile_interval < lower_bound
    result = {
        "issue detected": true,
        "msg": sprintf("The resource '%s' of kind '%s' reconcile interval must be at least %d seconds; found %d", [controller_input.metadata.name, controller_input.kind, lower_bound, reconcile_interval]),
        "violating_key": "spec.interval"
    }
}

violation[result] {
    isExcludedNamespace == false
    reconcile_interval := parse_interval(controller_spec.interval)
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    reconcile_interval > upper_bound
    result = {
        "issue detected": true,
        "msg": sprintf("The resource '%s' of kind '%s' reconcile interval must be at most %d seconds; found %d", [controller_input.metadata.name, controller_input.kind, upper_bound, reconcile_interval]),
        "violating_key": "spec.interval"
    }
}

# Controller input
controller_input = input.review.object

controller_spec = controller_input.spec {
  contains_kind(controller_input.kind, ["HelmRelease", "GitRepository", "OCIRepository", "Bucket", "HelmChart", "HelmRepository", "Kustomization"])
}

contains_kind(kind, kinds) {
kinds[_] = kind
}

isExcludedNamespace = true {
  controller_input.metadata.namespace
  controller_input.metadata.namespace in exclude_namespaces
} else = false

parse_interval(interval) {
    endswith(interval, "s")
    no_s := trim_suffix(interval, "s")
    seconds := to_number(no_s)
} else = seconds {
    endswith(interval, "m")
    no_m := trim_suffix(interval, "m")
    minutes := to_number(no_m)
    seconds := minutes * 60
} else = seconds {
    endswith(interval, "h")
    no_h := trim_suffix(interval, "h")
    hours := to_number(no_h)
    seconds := hours * 3600
} else {
    seconds := to_number(interval)
}
