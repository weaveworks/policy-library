package magalix.advisor.affinity.node_selector

test_key_value_exists {
	testcase = {
		"parameters": {
			"key": "disktype",
			"value": "ssd",
			"exclude_namespace": "",
			"exclude_label_key": "",
			"exclude_label_value": "",
		},
		"review": {
            "object": {
  "apiVersion": "v1",
  "kind": "Pod",
  "metadata": {
    "name": "with-node-affinity"
  },
  "spec": {
    "affinity": {
      "nodeAffinity": {
        "requiredDuringSchedulingRequiredDuringExecution": [
          {
            "weight": 1,
            "preference": {
              "matchExpressions": [
                {
                  "key": "another-node-label-key",
                  "operator": "In",
                  "values": [
                    "another-node-label-value"
                  ]
                }
              ]
            }
          }
        ],
        "requiredDuringSchedulingIgnoredDuringExecution": {
          "nodeSelectorTerms": [
            {
              "matchExpressions": [
                {
                  "key": "kubernetes.io/e2e-az-name",
                  "operator": "In",
                  "values": [
                    "e2e-az1",
                    "e2e-az2"
                  ]
                }
              ]
            }
          ]
        },
        "preferredDuringSchedulingIgnoredDuringExecution": [
          {
            "weight": 1,
            "preference": {
              "matchExpressions": [
                {
                  "key": "another-node-label-key",
                  "operator": "In",
                  "values": [
                    "another-node-label-value"
                  ]
                }
              ]
            }
          }
        ]
      },
      "podAffinity": {
        "requiredDuringSchedulingRequiredDuringExecution": [
          {
            "labelSelector": {
              "matchExpressions": [
                {
                  "key": "security",
                  "operator": "In",
                  "values": [
                    "S1"
                  ]
                }
              ]
            },
            "topologyKey": "failure-domain.beta.kubernetes.io/zone"
          }
        ],
        "preferredDuringSchedulingIgnoredDuringExecution": [
          {
            "labelSelector": {
              "matchExpressions": [
                {
                  "key": "security",
                  "operator": "In",
                  "values": [
                    "S1"
                  ]
                }
              ]
            },
            "topologyKey": "failure-domain.beta.kubernetes.io/zone"
          }
        ],
        "requiredDuringSchedulingIgnoredDuringExecution": [
          {
            "labelSelector": {
              "matchExpressions": [
                {
                  "key": "security",
                  "operator": "In",
                  "values": [
                    "S1"
                  ]
                }
              ]
            },
            "topologyKey": "failure-domain.beta.kubernetes.io/zone"
          }
        ]
      }
    },
    "containers": [
      {
        "name": "with-node-affinity",
        "image": "k8s.gcr.io/pause:2.0"
      }
    ],
    "nodeSelector": {
      "disktype": "ssd"
    }
  }
            }
    }
	}

	count(violation) == 0 with input as testcase
}