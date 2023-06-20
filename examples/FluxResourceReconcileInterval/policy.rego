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
        "issue_detected": true,
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
        "issue_detected": true,
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

parse_interval(interval) = seconds {
    # Matches strings like 1h2m3s, 2m, 10s and extracts hours, minutes, and seconds
    match_result := regex.find_n(`\d+h|\d+m|\d+s`, interval, 3)
    
    # Calculate total seconds
    total_seconds := sum([get_seconds_from_part(match) | match := match_result[_]])
    
    seconds = total_seconds
}

# Calculate seconds from part if present
get_seconds_from_part(part) = seconds {
    endswith(part, "h")
    no_suffix := trim_suffix(part, "h")
    seconds := to_number(no_suffix) * 3600
} else = seconds {
    endswith(part, "m")
    no_suffix := trim_suffix(part, "m")
    seconds := to_number(no_suffix) * 60
} else = seconds {
    endswith(part, "s")
    no_suffix := trim_suffix(part, "s")
    seconds := to_number(no_suffix)
} else = seconds {
    seconds := 0
}
