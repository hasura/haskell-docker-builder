# haskell-docker-builder
Package Haskell binaries into docker images.

# Use case:
If you can build statically linked binaries, you are better off using busybox directly. This approach is helpful when your executable is dependent on dynamically linked libraries.

# Quick start:
You can drop this Makefile into your project directory. This is assuming that your project uses `stack`. It can be easily modified to work with cabal. Replace `project` and `registry` with your own values.

```Makefile
project  := myproject
registry := myregistry

project_dir := $(shell pwd)
build_dir   := $(project_dir)/$(shell stack path --dist-dir)/build
version     := $(shell grep -oP '^version:\s*\K.*' $(project).cabal)

image: $(project).cabal
	stack build
	docker run --rm -v $(build_dir)/$(project)-exe/$(project)-exe:/root/$(project)-exe hasura/haskell-docker-packager:1.0 /build.sh $(project)-exe | docker import - $(registry)/$(project):$(version)

push: $(project).cabal
	docker push $(registry)/$(project):$(version)
```

You can now use `make image` to create the docker image.

# How does this work
The `make image` rule builds a bare minimal root filesystem with the haskell binary and all necessary libraries. This filesystem is imported as an image into docker.

The compiled binary is mounted into a debian builder image. A script inside the image processes the binary and copies all dynamically linked libraries into the root filesystem.

# Customising the builder image
You'll need to customise the builder image to add the libraries needed for the executable. For example, if the dependency is `libpq`, you can do this:
```Dockerfile
FROM hasura/haskell-docker-packager:1.0
RUN <apt install the library>
```

Update the `Makefile` to use this new image instead of `haskell-docker-packager`.
