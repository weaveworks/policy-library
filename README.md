# Magalix Policy Library

This is the Magalix Policy library v1.0.

## Directory Structure
```
├── policies
|   ├── Policy Name
│   |   ├── policy.yaml
│   |   ├── policy.rego
│   |   ├── tests
│   |   │   ├── xxx_test.yaml
├── examples
|   ├── Template Name
│   |   ├── policy.yaml
│   |   ├── policy.rego
│   |   ├── tests
│   |   │   ├── xxx_test.yaml
├── standards
│   ├── Standard Name
│   │   ├── standard.yaml
├── categories
│   ├── categories.yaml
├── scripts
│   ├── sync.py
│   ├── test_policies
├── crd.yaml
├── .githooks
```

## Policy Structure
- <b>Policy Directory Name:</b> This is the name of the Policy. Try to look at the other directories and follow the naming pattern if applicable.
- <b>policy.rego:</b> REGO code for the policy.
- <b>policy.yaml:</b> Policy CRD object that contains the spec of the policy.
- <b>tests:</b> This directory has:
    - Example `yaml` files that you can use to test the policies with `scripts/test_policies` binary.
    - REGO files to test the policies using OPA Testing Framework.

## Standards File Format
```
id: magalix.standards.<id> # mglx standard id
name: <standard name>
description: <description text>
controls:
- id: magalix.controls.<id> # mglx control id
  description: <description text>
  name: <control name>
  order: <order>
```

## Testing Policies
#### OPA Testing Framework
Run `opa test examples/ policies/ -v --ignore '*.yml','*.yaml'"`
#### Testing Binary
[TBD after modifying testing bin to reflect new changes]

## Syncing Policies
Using `scripts/sync.py` script
```bash
Usage: sync.py [OPTIONS] COMMAND [ARGS]...

  Sync script that syncs policies, templates, standards, controls and
  categories to Magalix policies service

Options:
  --help  Show this message and exit.

Commands:
  categories  Sync categories
  policies    Sync policies
  standards   Sync standards and controls
  templates   Sync templates
```
Example usage:
```bash
# sync policies/templates/standards/categories
python3 scripts/sync.py policies/templates/standards/categories

# view commands options
python3 scripts/sync.py policies --help

Commands Options:
  -d, --policies-dir           Policies directory  [required]
  -a, --magalix-account        Magalix account ID  [required]
  -s, --policies-service       Policies Service url  [required]
  --new-only                   Sync only new policies
  --sync-deleted               Sync deleted policies
  --help                       Show this message and exit.

# sync policies from custom dir
python3 scripts/sync.py policies --policies-dir <policies dir path>

# sync deleted standards
python3 scripts/sync.py standards --sync-deleted

# sync new and deleted templates
python3 scripts/sync.py templates --new-only --sync-deleted
```

<b>Sync Notes:</b>
- All commands (policies/templates/categories/standards) have same options
- `-d, -a, -s` options have default values. You can just use these options to override the default ones. Otherwise, you don't need to set them.

## Setup repo githooks
This command sets the path for the repo hooks to .githooks directory so that it can be version-controlled and used by everyone using this repo.
`git config --local core.hooksPath .githooks/`
