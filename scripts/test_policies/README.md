# Testing Policies

## test_policies

The `test_policies` binary will go over a template directory structure and run all the tests against each constraint available. If a constraint is not marked for sync it will be ignored as well as templates not having test cases or constraints.

### How to run

The availble command are: 

```bash
NAME:
   policies test - Test policy template code

USAGE:
   test_policies [global options] command [command options] [arguments...]

VERSION:
   0.0.1

COMMANDS:
   help, h  Shows a list of commands or help for one command

GLOBAL OPTIONS:
   --root-dir value       Root directory containing all template directories
   --template-path value  path to template dir
   --help, -h             show help (default: false)
   --version, -v          print the version (default: false)
```

To run against a single template and its constraints:

```bash
./test_policies --template-path {tempalte_path}
```

To run against all templates in the repo:

```bash
./test_policies --root-dir {repo_root}
```
