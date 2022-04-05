package weave.advisor.storage.persistentvolume_acccess_mode

test_key_value_exists {
	testcase = {
		"parameters": {
			"name": "test-volume",
			"access_mode": "ReadWriteOnce",
		},
		"review": {
            "object": {
                "apiVersion": "v1",
                "kind": "PersistentVolume",
                "metadata": {
                    "name": "test-volume"
                },
                "spec": {
                    "accessModes": [
                        "ReadWriteOnce"
                    ],
                    "capacity": {
                        "storage": "200Gi"
                    },
                    "gcePersistentDisk": {
                        "fsType": "ext4",
                        "pdName": "my-data-disk"
                    },
                    "storageClassName": "gcp-disk"
                } 
            }
	    }
    }
	count(violation) == 0 with input as testcase
}
