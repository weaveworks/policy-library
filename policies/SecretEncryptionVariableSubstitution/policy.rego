package weave.policies.secrets
import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

has_key(x, k) {
  _ = x[k]
}

isExcludedNamespace = true {
  obj.metadata.namespace
  obj.metadata.namespace in exclude_namespaces
} else = false

obj = input.review.object

enc_keys = [sprintf("data.%s", [key]) |
  obj.data[key]
  not startswith(obj.data[key], "ENC[")
]

tpl_keys = [sprintf("data.%s", [key]) |
  obj.data[key]
  not startswith(obj.data[key], "${")
]

violation[result] {
  isExcludedNamespace == false
  not exclude_label_value == obj.metadata.labels[exclude_label_key]
  has_key(obj, "sops")
  count(enc_keys) > 0

  some key in enc_keys

  result = {
    "issue_detected": true,
    "msg": sprintf("Secret is either not encrypted or not using Flux Substitute Variables: %s", [key]),
    "violating_key": key
  }
}

violation[result] {
  isExcludedNamespace == false
  not exclude_label_value == obj.metadata.labels[exclude_label_key]
  not has_key(obj, "sops")
  count(tpl_keys) > 0

  some key in tpl_keys

  result = {
    "issue_detected": true,
    "msg": sprintf("Secret is either not encrypted or not using Flux Substitute Variables: %s", [key]),
    "violating_key": key
  }
}
