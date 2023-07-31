# Weave Policy Library

This is the Weave Policy library v1.0.0.

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

## Policy and Template Structure
- <b>Policy Directory Name:</b> This is the name of the Policy. Try to look at the other directories and follow the naming pattern if applicable.
- <b>policy.rego:</b> REGO code for the policy.
- <b>policy.yaml:</b> Policy CRD object that contains the spec of the policy.
- <b>tests:</b> This directory has:
    - Example `yaml` files that you can use to test the policies with `scripts/test_policies` binary.
    - REGO files to test the policies using OPA Testing Framework.

## Standards File Format
```
id: weave.standards.<id> # weave standard id
name: <standard name>
description: <description text>
controls:
- id: weave.controls.<id> # weave control id
  description: <description text>
  name: <control name>
  order: <order>
```

## Testing Policies using OPA Testing Framework

Download it [here](https://www.openpolicyagent.org/docs/latest/#running-opa) 

```bash
# test all policies and examples
opa test examples/ policies/ -v --ignore '*.yml','*.yaml','.md','.csv'

# test single policy
opa test policies/ControllerContainerRunningAsRoot -v --ignore '*.yml','*.yaml','.md','.csv'
```

## Policy Management scripts
We use [polctl](https://github.com/weaveworks/polctl) management scripts to manage (test, automate and sync) policies, standards, etc...

## Setup repo githooks

`git config --local core.hooksPath .githooks/`

This command sets the path for the repo hooks to .githooks directory so that it can be version-controlled and used by everyone using this repo.
