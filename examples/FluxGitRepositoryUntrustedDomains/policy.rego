package weave.advisor.gitrepository_untrusted_domains

import future.keywords.in

untrusted_domains := input.parameters.untrusted_domains
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    repo_url := controller_spec.url
    is_untrusted := domain_matches(repo_url, untrusted_domains)
    is_untrusted
    result = {
        "issue detected": true,
        "msg": sprintf("The GitRepository '%s' targets an untrusted domain. Found: '%s'", [controller_input.metadata.name, repo_url]),
        "violating_key": "spec.url"
    }
}

domain_matches(url, domains) {
    startswith(url, "https://")
    parts := split(url, "/")
    count(parts) > 2
    domain := parts[2]
    domain in domains
}

controller_input = input.review.object

controller_spec = controller_input.spec {
    controller_input.kind == "GitRepository"
}

contains_kind(kind, kinds) {
    kinds[_] = kind
}

isExcludedNamespace = true {
    controller_input.metadata.namespace
    controller_input.metadata.namespace in exclude_namespaces
} else = false
