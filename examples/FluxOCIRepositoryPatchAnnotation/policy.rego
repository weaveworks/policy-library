package weave.advisor.ocirepository_patch_annotation

import future.keywords.in
import data.k8s.matches

provider := input.parameters.provider
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_meta.labels[exclude_label_key]
    patch_annotation := get_patch_for_provider(provider)
    not patch_exists(patch_annotation)
    result = {
        "issue detected": true,
        "msg": sprintf("The Kustomization '%s' must have a patch annotation that matches the provider '%s'. Annotation '%s' not found", [controller_input.metadata.name, provider, patch_annotation]),
        "violating_key": sprintf("patches[*].patch.%s", [patch_annotation])
    }
}

get_patch_for_provider(provider) = patch {
  provider == "aws"
  patch := "apiVersion: v1\nkind: ServiceAccount\nmetadata:\n  name: source-controller\n  annotations:\n    eks.amazonaws.com/role-arn: <role arn>"
} else = patch {
  provider == "azure"
  patch := "apiVersion: v1\nkind: ServiceAccount\nmetadata:\n  name: source-controller\n  namespace: flux-system\n  annotations:\n    azure.workload.identity/client-id: <AZURE_CLIENT_ID>\n  labels:\n    azure.workload.identity/use: \"true\""
} else = patch {
  provider == "gcp"
  patch := "apiVersion: v1\nkind: ServiceAccount\nmetadata:\n  name: source-controller\n  annotations:\n    iam.gke.io/gcp-service-account: <identity-name>"
}

patch_exists(patch_annotation) {
    some i
    patch := controller_input.spec.patches[i].patch
    patch == patch_annotation
}

controller_input = input.review.object

controller_meta = controller_input.metadata {
    controller_input.kind == "Kustomization"
}

isExcludedNamespace = true {
    controller_meta.namespace
    controller_meta.namespace in exclude_namespaces
} else = false
