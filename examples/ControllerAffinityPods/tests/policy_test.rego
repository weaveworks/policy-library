package weave.advisor.affinity.pods

import data.weave.advisor.affinity.pods.violation

test_container_affinity_pods_compliance {
  testcase = {
   "parameters":{
      "keys":["security"],
      "exclude_namespaces":[

      ],
      "exclude_label_key":"",
      "exclude_label_value":""
   },
   "review":{
      "object": {
        "apiVersion": "v1",
        "kind": "Pod",
        "metadata": {
            "name": "with-pod-affinity"
        },
        "spec": {
            "affinity": {
            "podAffinity": {
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
                    "topologyKey": "topology.kubernetes.io/zone"
                }
                ]
            },
            "podAntiAffinity": {
                "preferredDuringSchedulingIgnoredDuringExecution": [
                {
                    "weight": 100,
                    "podAffinityTerm": {
                    "labelSelector": {
                        "matchExpressions": [
                        {
                            "key": "security",
                            "operator": "In",
                            "values": [
                            "S2"
                            ]
                        }
                        ]
                    },
                    "topologyKey": "topology.kubernetes.io/zone"
                    }
                }
                ]
            }
            },
            "containers": [
            {
                "name": "with-pod-affinity",
                "image": "k8s.gcr.io/pause:2.0"
            }
            ]
        }
      }
    }
  }
  count(violation) == 0 with input as testcase
}

test_container_affinity_violation {
  testcase = {
   "parameters":{
      "keys":["violation"],
      "exclude_namespaces":[],
      "exclude_label_key":"",
      "exclude_label_value":""
   },
   "review":{
      "object": {
        "apiVersion": "v1",
        "kind": "Pod",
        "metadata": {
            "name": "with-pod-affinity"
        },
        "spec": {
            "affinity": {
            "podAffinity": {
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
                    "topologyKey": "topology.kubernetes.io/zone"
                }
                ]
            },
            "podAntiAffinity": {
                "preferredDuringSchedulingIgnoredDuringExecution": [
                {
                    "weight": 100,
                    "podAffinityTerm": {
                    "labelSelector": {
                        "matchExpressions": [
                        {
                            "key": "security",
                            "operator": "In",
                            "values": [
                            "S2"
                            ]
                        }
                        ]
                    },
                    "topologyKey": "topology.kubernetes.io/zone"
                    }
                }
                ]
            }
            },
            "containers": [
            {
                "name": "with-pod-affinity",
                "image": "k8s.gcr.io/pause:2.0"
            }
            ]
        }
      }
   }
}
  count(violation) == 1 with input as testcase
}

test_exclude_namespace {
  testcase = {
   "parameters":{
      "keys":["violation"],
      "exclude_namespaces":[
        "default"
      ],
      "exclude_label_key":"",
      "exclude_label_value":""
   },
   "review":{
      "object": {
        "apiVersion": "v1",
        "kind": "Pod",
        "metadata": {
            "name": "with-pod-affinity",
            "namespace": "default"
        },
        "spec": {
            "affinity": {
            "podAffinity": {
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
                    "topologyKey": "topology.kubernetes.io/zone"
                }
                ]
            },
            "podAntiAffinity": {
                "preferredDuringSchedulingIgnoredDuringExecution": [
                {
                    "weight": 100,
                    "podAffinityTerm": {
                    "labelSelector": {
                        "matchExpressions": [
                        {
                            "key": "security",
                            "operator": "In",
                            "values": [
                            "S2"
                            ]
                        }
                        ]
                    },
                    "topologyKey": "topology.kubernetes.io/zone"
                    }
                }
                ]
            }
            },
            "containers": [
            {
                "name": "with-pod-affinity",
                "image": "k8s.gcr.io/pause:2.0"
            }
            ]
        }
      }
   }

}
  count(violation) == 0 with input as testcase
}

test_exclude_label {
  testcase = {
   "parameters":{
      "keys":["violation"],
      "exclude_namespaces":[],
      "exclude_label_key":"allow-violation",
      "exclude_label_value":"true"
   },
   "review":{
      "object": {
        "apiVersion": "v1",
        "kind": "Pod",
        "metadata": {
            "name": "with-pod-affinity",
            "labels": {
                "allow-violation": "true"
            }
        },
        "spec": {
            "affinity": {
            "podAffinity": {
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
                    "topologyKey": "topology.kubernetes.io/zone"
                }
                ]
            },
            "podAntiAffinity": {
                "preferredDuringSchedulingIgnoredDuringExecution": [
                {
                    "weight": 100,
                    "podAffinityTerm": {
                    "labelSelector": {
                        "matchExpressions": [
                        {
                            "key": "security",
                            "operator": "In",
                            "values": [
                            "S2"
                            ]
                        }
                        ]
                    },
                    "topologyKey": "topology.kubernetes.io/zone"
                    }
                }
                ]
            }
            },
            "containers": [
            {
                "name": "with-pod-affinity",
                "image": "k8s.gcr.io/pause:2.0"
            }
            ]
        }
      }
   }

}
  count(violation) == 0 with input as testcase
}
