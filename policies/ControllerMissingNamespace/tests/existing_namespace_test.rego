package weave.advisor.namespace.missing_namespace

test_existing_namespace {
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
          },
          "namespace": "test-ns"
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




