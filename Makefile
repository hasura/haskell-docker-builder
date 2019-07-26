SHELL := /bin/bash

HASKELL_BUILDER_VERSION ?= $(shell date '+%Y%m%d')
BUSYBOX_BUILDER_VERSION := b806ff0a2624776464ec9c7ecbda16c2c9ec5e69

HASKELL_BUILDER_TAG := hasura/haskell-docker-packager:$(HASKELL_BUILDER_VERSION)
BUSYBOX_BUILDER_DOCKERFILE_URL := https://raw.githubusercontent.com/docker-library/busybox/$(BUSYBOX_BUILDER_VERSION)/glibc/Dockerfile.builder

build:
	image_id_file=$$(mktemp) && \
	docker build --iidfile "$$image_id_file" '$(BUSYBOX_BUILDER_DOCKERFILE_URL)' && \
	docker build . -t '$(HASKELL_BUILDER_TAG)' \
		--build-arg busybox_builder="$$(cat $$image_id_file)"

push: build
	docker push '$(HASKELL_BUILDER_TAG)'

.PHONY: build push
