package magalix.advisor.k8s.min_kubelet_version

version := input.parameters.version

violation[result] {
  kubelet_version := node_input.status.nodeInfo.kubeletVersion
  semantic_version := split_version(kubelet_version)
  your_version := split_version(version)
  verify := semver.compare(semantic_version, your_version)
  verify < 0
  result = {
 	"issue_detected": true,
    "msg": sprintf("Minimum version must be '%v'; found version 'v%v'", [version, semantic_version]),
    "violating_key": "status.nodeInfo.kubeletVersion"
  }
}

split_version(k_ver) = ver {
  split_vers := split(k_ver, "-")
  ver := trim_left(split_vers[0], "v")
}

node_input = input.review.object {
	contains_kind(input.review.object.kind, {"Node"})
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}

