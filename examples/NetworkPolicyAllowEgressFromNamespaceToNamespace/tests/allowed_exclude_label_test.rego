package weave.advisor.network.allow.egress.from_namespace_to_namespace

test_allowed_exclude_label {
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
          "name": "allow-egress-from-namespace-to-another",
          "namespace": "ns1",
          "labels": {
            "test_label": "OK"
          }
        },
        "spec": {
          "podSelector": {},
          "egress": [
            {
              "to": [
                {
                  "namespaceSelector": {
                    "matchLabels": {
                      "kubernetes.io/metadata.name": "ns3"
                    }
                  }
                }
              ]
            }
          ],
          "policyTypes": [
            "Egress"
          ]
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}