# v1.0.0    2016-06-20     webmaster@highskillz.com

IMAGE_NAME=ez123/db-mysql-safedir

THIS_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
TIMESTAMP=$(shell date -u +"%Y%m%d_%H%M%S%Z")

BUILD_OPTS=--pull --force-rm
#BUILD_OPTS=--force-rm

# --------------------------------------------------------------------------
default: build

# --------------------------------------------------------------------------
build: _DOCKER_BUILD_OPTS=$(BUILD_OPTS)
build: _build_image

rebuild: _DOCKER_BUILD_OPTS=--no-cache $(BUILD_OPTS)
rebuild: _build_image

_build_image: _check-env-base
	docker build $(_DOCKER_BUILD_OPTS) -t $(IMAGE_NAME):5.7-ssl  ./5.7-ssl-safedir

# --------------------------------------------------------------------------
_check-env-base:
	test -n "$(TIMESTAMP)"
	#test -n "$(TAG_NAME)"

# --------------------------------------------------------------------------
shell:shell-57sd

shell-57: _check-env-base
	docker run --rm -it $(IMAGE_NAME):5.7-ssl bash

# --------------------------------------------------------------------------
rmi: _check-env-base
	docker rmi $(IMAGE_NAME):5.7-ssl

# --------------------------------------------------------------------------
clean-junk:
	docker rm        `docker ps -aq -f status=exited`      || true
	docker rmi       `docker images -q -f dangling=true`   || true
	docker volume rm `docker volume ls -qf dangling=true`  || true

# --------------------------------------------------------------------------
list:
	docker images
	docker volume ls
	docker ps -a
