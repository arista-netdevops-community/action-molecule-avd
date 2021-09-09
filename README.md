![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/arista-netdevops-community/action-molecule-avd) ![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/avdteam/action-molecule) ![Docker Pulls](https://img.shields.io/docker/pulls/avdteam/action-molecule) ![GitHub](https://img.shields.io/github/license/arista-netdevops-community/action-molecule-avd)

# Github  Action for Molecule

First GitHub action allows you to run [Molecule](https://molecule.readthedocs.io/en/latest/) using [ansible collection](https://docs.ansible.com/ansible/latest/user_guide/collections_using.html) structure.

In addition, this GH action supports GIT status after Molecule execution to help to track unexpected file changes. This check can be enforced and generate a failure if a change is detected.

## Inputs

```yaml
---
  molecule_parentdir:
    description: Relative path where your molecule folder is.
    required: no

  molecule_options:
    description: |
      Supported options:
        --debug / --no-debug    Enable or disable debug mode. Default is disabled.
        -c, --base-config TEXT  Path to a base config.  If provided Molecule will
                                load this config first, and deep merge each
                                scenario's molecule.yml on top.
        -e, --env-file TEXT     The file to read variables from when rendering
                                molecule.yml. (.env.yml)
        --version               Show the version and exit.
        --help                  Show this message and exit.
    required: false

  molecule_command:
    description: |
      Supported commands:
        check        Use the provisioner to perform a Dry-Run...
        cleanup      Use the provisioner to cleanup any changes...
        converge     Use the provisioner to configure instances...
        create       Use the provisioner to start the instances.
        dependency   Manage the role's dependencies.
        destroy      Use the provisioner to destroy the instances.
        idempotence  Use the provisioner to configure the...
        init         Initialize a new role or scenario.
        lint         Lint the role.
        list         Lists status of instances.
        login        Log in to one instance.
        matrix       List matrix of steps used to test instances.
        prepare      Use the provisioner to prepare the instances...
        side-effect  Use the provisioner to perform side-effects...
        syntax       Use the provisioner to syntax check the role.
        test         Test (lint, cleanup, destroy, dependency,...
        verify       Run automated tests against instances.
    required: true
    default: 'test'

  molecule_args:
    description: |
      Supported arguments:
        --scenario-name foo  Targeting a specific scenario.
        --driver-name foo    Targeting a specific driver.
        --all                Target all scenarios.
        --destroy=always     Always destroy instances at the conclusion of a Molecule run.
    required: false

  pip_file:
    description: |
      Relative path from `${GITHUB_REPOSITORY}` to install
      any requirements prior to run molecule
    required: false

  ansible:
    description: |
      Ansible package to install
      Support pip syntax to target specific version
    required: false
    default: 'ansible'

  galaxy_file:
    description: |
      Relative path from `${GITHUB_REPOSITORY}` to install
      any requirements from Ansible Galaxy prior to run molecule
    required: false
    default: ''

  check_git:
    description: |
      Check git status after molecule execution.
      Help to track unexpected changes between 2 commits.
    required: false

  check_git_enforced:
    description: |
      If set to to true, then exit code is based on git status.
    required: false
```

## Usage

To use the action simply create an main.yml (or choose custom *.yml name) in the .github/workflows/ directory.
Basic example:

```yaml
on: push

jobs:
  molecule:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Run molecule action
        uses: arista-netdevops-community/action-molecule-avd@v1.0
        with:
          molecule_parentdir: 'ansible_collections/arista/cvp'
          molecule_command: 'test'
          molecule_args: '--all'
          ansible: ansible>=2.10
          pip_file: 'requirements.txt'
          check_git: true
          check_git_enforced: false
```

## Local testing

To test action execution locally, configure variables in a file:

```shell
# cat test.env
INPUT_PIP_FILE=requirements.txt
INPUT_MOLECULE_PARENTDIR=/root/ansible_collections/arista/cvp
INPUT_MOLECULE_COMMAND=test
INPUT_MOLECULE_ARGS=--all
```

Then run docker container:

```shell
docker run --rm -it \
    -v ${PWD}:/root/ \                              # Local content shared with container
    -v /var/run/docker.sock:/var/run/docker.sock \  # Docker process required by molecule
    --env-file dev.env \                            # File with your variables
    avdteam/action-molecule:v1.0
```
