package weave.advisor.bucket_endpoint_domain

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value
domains := input.parameters.domains

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    not is_trusted_domain(controller_spec.endpoint)
    result = {
        "issue detected": true,
        "msg": sprintf("The Bucket '%s' has an endpoint domain that is not in the trusted domains list: %v; found '%s'", [controller_input.metadata.name, domains, controller_spec.endpoint]),
        "violating_key": "spec.endpoint"
    }
}

# Controller input
controller_input = input.review.object

# controller_container acts as an iterator to get containers from the template
controller_spec = controller_input.spec {
  controller_input.kind == "Bucket"
}

contains_kind(kind, kinds) {
    kinds[_] = kind
}

isExcludedNamespace = true {
    controller_input.metadata.namespace
    controller_input.metadata.namespace in exclude_namespaces
} else = false

is_trusted_domain(endpoint) {
    # Split endpoint into parts
    domain_parts := split(endpoint, ".")

    # Extract last two parts (main domain) from domain_parts
    main_domain := {domain_parts[n] | n = count(domain_parts) - i - 1, i = [0, 1]}

    # Check if main_domain is in the trusted list
    concat(".", main_domain) in domains
}



