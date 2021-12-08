package magalix.advisor.network.allow.ingress.from_namespace_to_namespace

test_violation_allow_all_ingress {
  testcase = {
    "parameters": {
      "src_namespace": "ns1",
      "dst_namespace": "ns2",
      "exclude_label_key": "test_label",
      "exclude_label_value": "OK"
    },
    "review": {
      "object": {
        "apiVersion": "networking.k8s.io/v1",
        "kind": "NetworkPolicy",
        "metadata": {
          "name": "allow-ingress-from-namespace-to-another",
          "namespace": "ns2"
        },
        "spec": {
          "podSelector": {},
          "ingress": [
            {}
          ],
          "policyTypes": [
            "Igress"
          ]
        }
      }
    }
  }

  violation with input as testcase
}