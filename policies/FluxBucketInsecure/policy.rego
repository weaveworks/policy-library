package weave.advisor.bucket_insecure_connections

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    controller_spec.insecure == true
    result = {
        "issue_detected": true,
        "msg": "Insecure connections are not allowed for Bucket objects. Please set 'spec.insecure' to 'false' or remove the field.",
        "violating_key": "spec.insecure",
        "recommended_value": "false"  
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
