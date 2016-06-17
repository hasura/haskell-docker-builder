# haskell-docker-builder
Guide on how to build a minimal docker image for haskell

# Steps
0. Clone this repo, or just copy the Makefile
1. Replace ``myproject`` and ``myregistry`` with appropriate values in the Makefile
2. Copy the Makefile to your haskell repo (stack)
3. Run the Makefile commands
4. ``make image`` builds the docker image
4. ``make push`` pushes the docker image to the given registry
