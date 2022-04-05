package weave.advisor.namespace.missing_namespace

test_missing_namespace {
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
            "name": "mypod"
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
  
  violation with input as testcase
}




