package weave.advisor.container.enforce_env_var

import data.weave.advisor.container.enforce_env_var.violation

test_policy_compliance {
  testcase = {
   "parameters":{
    "envvar_name": "MYSQL_ROOT_PASSWORD",
      "exclude_namespaces":[

      ],
      "exclude_label_key":"",
      "exclude_label_value":""
   },
   "review":{
      "object":{
        "apiVersion": "apps/v1",
        "kind": "Deployment",
        "metadata": {
            "name": "mariadb"
        },
        "spec": {
            "spec": {
            "containers": [
                {
                "image": "mariadb:10.6",
                "name": "mariadb",
                "env": [
                    {
                    "name": "MYSQL_ROOT_PASSWORD",
                    "value": "password"
                    },
                    {
                    "name": "MARIADB_ROOT_PASSWORD",
                    "value": "password"
                    }
                ]
                }
            ]
            }
        }
}
   }
}
  count(violation) == 0 with input as testcase
}

test_policy_violation {
  testcase = {
   "parameters":{
      "envvar_name": "MYSQL_PASSWORD",
      "exclude_namespaces":[

      ],
      "exclude_label_key":"",
      "exclude_label_value":""
   },
   "review":{
    "object":{
        "apiVersion": "apps/v1",
        "kind": "Deployment",
        "metadata": {
            "name": "mariadb"
        },
        "spec": {
            "spec": {
            "containers": [
                {
                "image": "mariadb:10.6",
                "name": "mariadb",
                "env": [
                    {
                    "name": "MYSQL_ROOT_PASSWORD",
                    "value": "password"
                    },
                    {
                    "name": "MARIADB_ROOT_PASSWORD",
                    "value": "password"
                    }
                ]
                }
            ]
            }
        }
}
   }
}
  count(violation) == 1 with input as testcase
}

# test_exclude_namespace {
#   testcase = {
#    "parameters":{
#       "exclude_namespaces":[
#         "default"
#       ],
#       "exclude_label_key":"",
#       "exclude_label_value":""
#    },
#    "review":{
#       "object":{
#   "apiVersion": "apps/v1",
#   "kind": "Deployment",
#   "metadata": {
#     "name": "mariadb"
#   },
#   "spec": {
#     "spec": {
#       "containers": [
#         {
#           "image": "mariadb:10.6",
#           "name": "mariadb",
#           "env": [
#             {
#               "name": "MYSQL_ROOT_PASSWORD",
#               "value": "password"
#             },
#             {
#               "name": "MARIADB_ROOT_PASSWORD",
#               "value": "password"
#             }
#           ]
#         }
#       ]
#     }
#   }
# }
#    }

# }
#   count(violation) == 0 with input as testcase
# }

# test_exclude_label {
#   testcase = {
#    "parameters":{
#       "exclude_namespaces":[
#       ],
#       "exclude_label_key": "allow-violation",
#       "exclude_label_value": "true",
#    },
#    "review":{
#       "object":{
#   "apiVersion": "apps/v1",
#   "kind": "Deployment",
#   "metadata": {
#     "name": "mariadb"
#   },
#   "spec": {
#     "spec": {
#       "containers": [
#         {
#           "image": "mariadb:10.6",
#           "name": "mariadb",
#           "env": [
#             {
#               "name": "MYSQL_ROOT_PASSWORD",
#               "value": "password"
#             },
#             {
#               "name": "MARIADB_ROOT_PASSWORD",
#               "value": "password"
#             }
#           ]
#         }
#       ]
#     }
#   }
# }
#    }
# }
#   count(violation) == 0 with input as testcase
# }
