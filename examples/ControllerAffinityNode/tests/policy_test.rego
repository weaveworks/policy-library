package weave.advisor.affinity.nodes

import data.weave.advisor.affinity.nodes.violation

test_container_affinity_compliance {
  testcase = {
   "parameters":{
      "keys":["kubernetes.io/e2e-az-name", "another-node-label-key"],
      "exclude_namespaces":[

      ],
      "exclude_label_key":"",
      "exclude_label_value":""
   },
   "review":{
      "object":{
         "apiVersion":"v1",
         "kind":"Pod",
         "metadata":{
            "name":"with-node-affinity"
         },
         "spec":{
            "affinity":{
               "nodeAffinity":{
                  "requiredDuringSchedulingIgnoredDuringExecution":{
                     "nodeSelectorTerms":[
                        {
                           "matchExpressions":[
                              {
                                 "key":"kubernetes.io/e2e-az-name",
                                 "operator":"In",
                                 "values":[
                                    "e2e-az1",
                                    "e2e-az2"
                                 ]
                              }
                           ]
                        }
                     ]
                  },
                  "preferredDuringSchedulingIgnoredDuringExecution":[
                     {
                        "weight":1,
                        "preference":{
                           "matchExpressions":[
                              {
                                 "key":"another-node-label-key",
                                 "operator":"In",
                                 "values":[
                                    "another-node-label-value"
                                 ]
                              }
                           ]
                        }
                     }
                  ]
               }
            },
            "containers":[
               {
                  "name":"with-node-affinity",
                  "image":"k8s.gcr.io/pause:2.0"
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
      "keys":["kubernetes.io/e2e-az-name"],
      "exclude_namespaces":[

      ],
      "exclude_label_key":"",
      "exclude_label_value":""
   },
   "review":{
      "object":{
         "apiVersion":"v1",
         "kind":"Pod",
         "metadata":{
            "name":"with-node-affinity"
         },
         "spec":{
            "affinity":{
               "nodeAffinity":{
                  "preferredDuringSchedulingIgnoredDuringExecution":[
                     {
                        "weight":1,
                        "preference":{
                           "matchExpressions":[
                              {
                                 "key":"another-node-label-key",
                                 "operator":"In",
                                 "values":[
                                    "another-node-label-value"
                                 ]
                              }
                           ]
                        }
                     }
                  ]
               }
            },
            "containers":[
               {
                  "name":"with-node-affinity",
                  "image":"k8s.gcr.io/pause:2.0"
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
      "keys":["kubernetes.io/e2e-az-name"],
      "exclude_namespaces":[
        "default"
      ],
      "exclude_label_key":"",
      "exclude_label_value":""
   },
   "review":{
      "object":{
         "apiVersion":"v1",
         "kind":"Pod",
         "metadata":{
            "name":"with-node-affinity",
            "namespace": "default"
         },
         "spec":{
            "affinity":{
               "nodeAffinity":{
                  "preferredDuringSchedulingIgnoredDuringExecution":[
                     {
                        "weight":1,
                        "preference":{
                           "matchExpressions":[
                              {
                                 "key":"another-node-label-key",
                                 "operator":"In",
                                 "values":[
                                    "another-node-label-value"
                                 ]
                              }
                           ]
                        }
                     }
                  ]
               }
            },
            "containers":[
               {
                  "name":"with-node-affinity",
                  "image":"k8s.gcr.io/pause:2.0"
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
      "keys":["kubernetes.io/e2e-az-name"],
      "exclude_namespaces":[
      ],
      "exclude_label_key": "allow-violation",
      "exclude_label_value": "true",
   },
   "review":{
      "object":{
         "apiVersion":"v1",
         "kind":"Pod",
         "metadata":{
            "name":"with-node-affinity",
            "labels": {
            "allow-violation": "true"
          },
         },
         "spec":{
            "affinity":{
               "nodeAffinity":{
                  "preferredDuringSchedulingIgnoredDuringExecution":[
                     {
                        "weight":1,
                        "preference":{
                           "matchExpressions":[
                              {
                                 "key":"another-node-label-key",
                                 "operator":"In",
                                 "values":[
                                    "another-node-label-value"
                                 ]
                              }
                           ]
                        }
                     }
                  ]
               }
            },
            "containers":[
               {
                  "name":"with-node-affinity",
                  "image":"k8s.gcr.io/pause:2.0"
               }
            ]
         }
      }
   }
}
  count(violation) == 0 with input as testcase
}
