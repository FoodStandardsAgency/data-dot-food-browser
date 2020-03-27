.PHONY:	build push

PREFIX = 293385631482.dkr.ecr.eu-west-1.amazonaws.com/epimorphics/amp
IMAGE = data-dot-food-browser
TAG = 0.0.2

all: build push

build:
	@docker build --tag ${PREFIX}/${IMAGE}:${TAG} .

push:
	@docker push ${PREFIX}/${IMAGE}:${TAG}
