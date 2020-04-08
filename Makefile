.PHONY:	clean dev image release prod tag test

PREFIX = 293385631482.dkr.ecr.eu-west-1.amazonaws.com/epimorphics/amp
IMAGE = data-dot-food-browser
TAG = 0.0.3

all: image test tag release

image:
	@docker build --tag ${IMAGE}:${TAG} .

dev:
	@docker run --rm --name data-dot-food-browser -p3000:3000 -e RAILS_ENV=development -e FSA_DATA_DOT_FOOD_API_URL=http://18.202.57.165:8080 ${IMAGE}:${TAG}

prod:
	@docker run --rm --name data-dot-food-browser -p3000:3000 -e RAILS_ENV=production -e FSA_DATA_DOT_FOOD_API_URL=http://18.202.57.165:8080 ${IMAGE}:${TAG}

test:
	@-docker stop data-dot-food-browser 2> /dev/null
	@docker run -d --rm --name data-dot-food-browser -p3000:3000 -e FSA_DATA_DOT_FOOD_API_URL=http://18.202.57.165:8080 -e RAILS_ENV=development ${IMAGE}:${TAG}
	@docker exec -it -e FSA_DATA_DOT_FOOD_API_URL=http://18.202.57.165:8080 -e RAILS_ENV=development data-dot-food-browser ./bin/rails test
	@docker stop data-dot-food-browser

tag:
	@docker tag ${IMAGE}:${TAG} ${PREFIX}/${IMAGE}:${TAG} 

release:
	@docker push ${PREFIX}/${IMAGE}:${TAG}

clean:
	@rake clobber clean webpacker:clobber tmp:clear
