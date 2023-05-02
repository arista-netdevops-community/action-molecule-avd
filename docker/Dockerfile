FROM python:3.10-slim

LABEL "maintainer"="Ansible Team <ansible@arista.com>"
LABEL "repository"="https://github.com/arista-netdevops-community/action-molecule-avd"
LABEL "homepage"="https://github.com/arista-netdevops-community/action-molecule-avd"

LABEL "com.github.actions.name"="molecule"
LABEL "com.github.actions.description"="Run Ansible Molecule"
LABEL "com.github.actions.icon"="upload"
LABEL "com.github.actions.color"="green"

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential wget git curl rsync && \
    curl -fsSL https://get.docker.com | sh
RUN pip install --upgrade pip molecule "molecule-plugins[docker]"
# As this container is intended to be run as a github action, we make
# /github/workspace safe by default
# TODO - this could probably be implemented better if required in the future by
# giving the option to use an input parameter
RUN git config --global --add safe.directory /github/workspace
ADD molecule-runner.sh /bin/molecule-runner.sh

WORKDIR /projects

ENTRYPOINT ["sh", "-c", "/bin/molecule-runner.sh"]
