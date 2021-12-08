package magalix.advisor.namespace.missing_namespace

test_missing_namespace_exclude_label {
  testcase = {
    "parameters": {
        "exclude_label_key": "test_label",
        "exclude_label_value": "OK"
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "Pod",
        "metadata": {
          "name": "mypod",
          "labels": {
            "name": "mypod",
            "test_label": "OK"
          }
        },
        "spec": {
          "containers": [
            {
              "name": "mynginx",
              "image": "nginx"
            }
          ]
        }
      }
    }
  }
  
  count(violation) == 0 with input as testcase
}




