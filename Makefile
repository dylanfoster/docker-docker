.PHONY: build test all

BUILD_TAG ?= latest
DOCKER_IMAGE_NAME = dylanfoster/docker
DOCKER_IMAGE_TAGS = 1.7.0 1.7 1 latest

all: build test tag

build:
	docker build -t $(DOCKER_IMAGE_NAME):$(BUILD_TAG) .

push:
	for tag in $(DOCKER_IMAGE_TAGS); do \
		docker push $(DOCKER_IMAGE_NAME):$$tag; \
	done

tag:
	for tag in $(DOCKER_IMAGE_TAGS); do \
		docker tag -f $(DOCKER_IMAGE_NAME):$(BUILD_TAG) \
			$(DOCKER_IMAGE_NAME):$$tag; \
	done

test:
	docker run --rm \
		-v $(CURDIR):/app \
		-v /var/run/docker.sock:/docker.sock \
		-e DOCKER_HOST="unix:///docker.sock" \
		-e DOCKER_IMAGE_NAME=$(DOCKER_IMAGE_NAME) \
		-e BUILD_TAG=$(BUILD_TAG) \
		dylanfoster/bats \
			/app/tests
