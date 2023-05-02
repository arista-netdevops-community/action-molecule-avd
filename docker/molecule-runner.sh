#!/bin/bash
#
# Purpose: Molecule runner for github-action
# Author: @titom73
# Date: 2020-12-16
# Version: 1.1
# License: APACHE
# --------------------------------------


# export PATH=$(echo "$PATH" | sed -e 's/:\/home\/avd\/.local\/bin//')
echo "Script running from ${PWD}"
git config --global --add safe.directory ${PWD}

# Install Ansible package
echo "container should run with following ansible input: ${INPUT_ANSIBLE}"
ansible_pattern="^ansible*"
if [[ $INPUT_ANSIBLE =~ $ansible_pattern ]]; then
    echo 'installing specific ansible version '${INPUT_ANSIBLE}+' ...'
    pip install ${INPUT_ANSIBLE}
else
    echo 'installing latest ansible version ...'
    pip install ansible
fi

# If user define any requirements file in options, we install them
if [ ${INPUT_PIP_FILE} != '' ] 2> /dev/null && [ -f ${INPUT_PIP_FILE} ]; then
    echo 'installing custom requirements file ...'
    echo 'PIP file is set to : '${INPUT_PIP_FILE}
    # Workaround for https://github.com/ansible/ansible/issues/70348
    pip install --upgrade -r ${INPUT_PIP_FILE}
    # Workaround
    # https://github.com/ansible-community/molecule/pull/3904
    pip install ansible-compat<4.0.1
fi

# If user define any galaxy requirements file in options, we install them
if [ ${INPUT_GALAXY_FILE} != '' ] 2> /dev/null && [ -f ${INPUT_GALAXY_FILE} ]; then
    echo 'installing custom Galaxy requirements file ...'
    echo 'Galaxy file is set to : '${INPUT_GALAXY_FILE}
    ansible-galaxy install -r ${INPUT_GALAXY_FILE}
fi

export MOLECULE_BIN=$(which molecule)

# Set default value for where to find MOLECULE folder
cd ${INPUT_MOLECULE_PARENTDIR}
echo "Current working dir: $PWD"

# Test if ansible is available
if ! [ -x "$(command -v ansible)" ]; then
    echo "Ansible not found !"
    exit 1
fi

# Run Molecule scenario
echo "Running: molecule ${INPUT_MOLECULE_OPTIONS} ${INPUT_MOLECULE_COMMAND} ${INPUT_MOLECULE_ARGS}"
${MOLECULE_BIN} --version
${MOLECULE_BIN} ${INPUT_MOLECULE_OPTIONS} ${INPUT_MOLECULE_COMMAND} ${INPUT_MOLECULE_ARGS}
export MOLECULE_STATE=$?

if [ ${MOLECULE_STATE} -ne 0 ]; then
    echo "Molecule failed! Exiting action with error code "${MOLECULE_STATE}
    exit ${MOLECULE_STATE}
fi

if [ ${INPUT_CHECK_GIT} = "true" ]; then
    git config core.fileMode false
    echo "  * Run Git Verifier because CHECK_GIT is set to ${INPUT_CHECK_GIT}"
    # if git diff-index --quiet HEAD --; then
    GIT_STATUS="$(git status --porcelain)"
    if  [ "$?" -ne "0" ]; then
        echo "'git status --porcelain' failed to run - something is wrong"
        exit 1
    fi
    if [ -n "$GIT_STATUS" ]; then
        # Some changes
        echo 'Some changes'
        echo '------------'
        git --no-pager status --short
        echo ''
        echo 'Diffs are:'
        echo '------------'
        git --no-pager diff
        if [ ${INPUT_CHECK_GIT_ENFORCED} = "true" ]; then
            exit 1
        else
            exit 0
        fi
    else
        # No Changes
        echo '    - No change found after running Molecule'
        exit 0
    fi
    exit 0
else
    echo "  * Git verifier skipped as not set to true"
fi
