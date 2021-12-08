package magalix.advisor.network.allow.ingress.from_namespace_to_namespace

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
          "name": "allow-ingress-from-namespace-to-another",
          "namespace": "ns2",
          "labels": {
            "test_label": "OK"
          }
        },
        "spec": {
          "podSelector": {},
          "ingress": [
            {
              "from": [
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
            "Ingress"
          ]
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}