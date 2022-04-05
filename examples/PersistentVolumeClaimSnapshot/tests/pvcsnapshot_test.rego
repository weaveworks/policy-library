package weave.advisor.storage.persistentvolumeclaim_snapshot

test_key_value_exists {
	testcase = {
		"parameters": {
			"snapshot_class": "csi-hostpath-snapclass",
			"pvc_name": "pvc-test",
			"exclude_namespace": "",
			"exclude_label_key": "",
			"exclude_label_value": "",
		},
		"review": {
            "object": {
                "apiVersion": "snapshot.storage.k8s.io/v1",
                "kind": "VolumeSnapshot",
                "metadata": {
                    "name": "new-snapshot-test"
                },
                "spec": {
                    "volumeSnapshotClassName": "csi-hostpath-snapclass",
                    "source": {
                        "persistentVolumeClaimName": "pvc-test"
                    }
                } 
            }
	    }
    }
	count(violation) == 0 with input as testcase
}
