package weave.advisor.helm_release_service_account_name

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value
hostnames := input.parameters.hostnames

violation[result] {
    isExcludedNamespace == false
    service_account_name := controller_spec.serviceAccountName
    not service_account_name in hostnames
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    result = {
        "issue detected": true,
        "msg": sprintf("The HelmRelease '%s' serviceAccountName must contain a value from parameters.hostnames; found '%s'", [controller_input.metadata.name, service_account_name]),
        "violating_key": "spec.serviceAccountName"
    }
}

controller_input = input.review.object

controller_spec = controller_input.spec {
  controller_input.kind == "HelmRelease"
}

isExcludedNamespace = true {
  controller_input.metadata.namespace
  controller_input.metadata.namespace in exclude_namespaces
} else = false
