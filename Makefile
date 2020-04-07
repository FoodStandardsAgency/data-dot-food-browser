.PHONY:	build push

PREFIX = 293385631482.dkr.ecr.eu-west-1.amazonaws.com/epimorphics/amp
IMAGE = data-dot-food-browser
TAG = 0.0.3

all: build tag push

build:
	@docker build --tag ${IMAGE}:${TAG} .

tag:
	@docker tag ${PREFIX}/${IMAGE}:${TAG} ${IMAGE}:${TAG} 

push:
	@docker push ${PREFIX}/${IMAGE}:${TAG}

run:
	@docker run --rm --name data-dot-food-browser t -p3000:3000 -e FSA_DATA_DOT_FOOD_API_URL=http://18.202.57.165:8080 -e RAILS_ENV=development ${IMAGE}:${TAG}

