    package weave.advisor.resource_labels_annotations

    import future.keywords.in

    labels := input.parameters.labels
    annotations := input.parameters.annotations
    exclude_namespaces := input.parameters.exclude_namespaces
    exclude_label_key := input.parameters.exclude_label_key
    exclude_label_value := input.parameters.exclude_label_value
 

    violation[result] {
        isExcludedNamespace == false
        not exclude_label_value == controller_metadata.labels[exclude_label_key]
        label := labels[_]
        not controller_metadata.labels[label.key] == label.value
        result = {
            "issue_detected": true,
            "msg": sprintf("The resource '%s' must have the label '%s' with value '%s'", [controller_metadata.name, label.key, label.value]),
            "violating_key": sprintf("metadata.labels.%s", [label.key])
        }
    }

    violation[result] {
        isExcludedNamespace == false
        not exclude_label_value == controller_metadata.labels[exclude_label_key]
        annotation := annotations[_]
        not controller_metadata.annotations[annotation.key] == annotation.value
        result = {
            "issue_detected": true,
            "msg": sprintf("The resource '%s' must have the annotation '%s' with value '%s'", [controller_metadata.name, annotation.key, annotation.value]),
            "violating_key": sprintf("metadata.annotations.%s", [annotation.key])
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
