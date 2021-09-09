FROM python:3.8-slim
# FROM avdteam/base:3.6

LABEL "maintainer"="Thomas Grimonet <tgrimonet@arista.com>"
LABEL "repository"="https://github.com/titom73/molecule-collection-actions"
LABEL "homepage"="https://github.com/titom73/molecule-collection-actions"

LABEL "com.github.actions.name"="molecule"
LABEL "com.github.actions.description"="Run Ansible Molecule"
LABEL "com.github.actions.icon"="upload"
LABEL "com.github.actions.color"="green"

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential wget git curl && \
    curl -fsSL https://get.docker.com | sh
RUN pip install --upgrade pip molecule molecule-docker
ADD molecule-runner.sh /bin/molecule-runner.sh

WORKDIR /projects

ENTRYPOINT ["sh", "-c", "/bin/molecule-runner.sh"]