TOP_DIR=.
VERSION=$(strip $(shell cat version))

dep:
	@echo "Install dependencies required for this repo..."
	@cd src; mix deps.get

build:
	@echo "Building the software..."
	@cd src; mix format; mix compile

run:
	@echo "Running the software..."
	@cd src; iex -S mix

test:
	@echo "Running test suites..."
	@cd src; mix test

travis-init:
	@echo "Initialize software required for travis (normally ubuntu software)"

travis: dep build test

travis-deploy: release
	@echo "Deploy the software by travis"

include .makefiles/*.mk
