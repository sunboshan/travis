RELEASE_VERSION=v$(VERSION)
GIT_BRANCH=$(strip $(shell git symbolic-ref --short HEAD))
GIT_VERSION="$(strip $(shell git rev-parse --short HEAD))"

release:
	@git tag $(RELEASE_VERSION) || true

bump-version:
	@echo "Bump version..."
	@.makefiles/bump_version.sh

create-pr:
	@echo "Creating pull request..."
	@make bump-version || true
	@git add CHANGELOG.md version;git commit -m "bump version";git push origin $(GIT_BRANCH)
	@hub pull-request
