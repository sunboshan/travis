TOP_DIR=.
VERSION=$(strip $(shell cat version))

dep:
	@echo "Install dependencies required for this repo..."
	@mix deps.get

build:
	@echo "Building the software..."
	@mix format; mix compile

run:
	@echo "Running the software..."
	@iex -S mix

test:
	@echo "Running test suites..."
	@mix test

travis-init:
	@echo "Initialize software required for travis (normally ubuntu software)"

# travis: dep build test
travis:
	whoami
	id
	groups

travis-deploy: release
	@echo "Deploy the software by travis"

include .makefiles/*.mk

.PHONY: test
