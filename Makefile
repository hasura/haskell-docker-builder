project := myproject
current_dir := $(shell pwd)
stack_build_dir := $(current_dir)/.stack-work/dist/x86_64-linux/Cabal-1.22.5.0/build
registry := myregistry
version := $(shell grep -oP '^version:\s*\K.*' myproject.cabal)

image: $(project).cabal
	stack build
	docker run --rm -v $(stack_build_dir)/$(project)-exe/$(project)-exe:/root/$(project) hasura/haskell-docker-packager:1.0 /build.sh $(project) | docker import - $(registry)/$(project):$(version)

push: $(project).cabal
	docker push $(registry)/$(project):$(version)
