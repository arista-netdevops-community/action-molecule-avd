CURRENT_DIR = $(shell pwd)
DOCKER_NAME ?= action-molecule
DOCKER_BASE ?= avdteam
DOCKER_TAG ?= v1.0
DOCKER_DIR ?= .

.PHONY: help
help: ## Display help message
	@grep -E '^[0-9a-zA-Z_-]+\.*[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: build
build: ## Build docker image
	docker build -t $(DOCKER_BASE)/$(DOCKER_NAME):$(DOCKER_TAG) $(DOCKER_DIR)

.PHONY: run
run: ## run docker image
	docker run --rm -it -v ${PWD}:/projects -v /var/run/docker.sock:/var/run/docker.sock --env-file dev.env $(DOCKER_BASE)/$(DOCKER_NAME):$(DOCKER_TAG)

.PHONY: exec
exec: ## exec docker image
	docker run --rm -it \
		--env-file dev.env \
		-v ${PWD}:/projects \
		-v /var/run/docker.sock:/var/run/docker.sock \
		$(DOCKER_BASE)/$(DOCKER_NAME):$(DOCKER_TAG)

.PHONY: connect
connect: ## exec docker image
	docker run --rm -it --entrypoint bash\
		--env-file dev.env \
		-v ${PWD}:/projects \
		-v /var/run/docker.sock:/var/run/docker.sock \
		$(DOCKER_BASE)/$(DOCKER_NAME):$(DOCKER_TAG)