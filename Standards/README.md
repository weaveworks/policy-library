# Syncing Standards


## Format
```
controls:
- description: Some Text
  name: Host file system tampering
  order: 1.2.3
description: Description
name: Standard Name
rid: mglx_standard_name
```

## Sync
When syncing for the first time to an environment, the `standard.yaml` file will get modified with ID information automatically. 
```
python3 Standards/sync.py  -d Standards/<standard dir> -e <env>
```