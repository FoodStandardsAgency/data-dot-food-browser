.PHONY:	clean image release prod tag test help version

PREFIX ?= 293385631482.dkr.ecr.eu-west-1.amazonaws.com/epimorphics/amp
IMAGE ?= data-dot-food-browser
FSA_DATA_DOT_FOOD_API_URL ?= http://18.202.57.165:8080

ifeq ($(origin SECRET_KEY_BASE), undefined)
SECRET_KEY_BASE != rails secret
endif

APP_VERSION != ruby -I . -e 'require "app/lib/version" ; puts Version::VERSION'

all: image test tag release

version:
	@echo App version is ${APP_VERSION}

help:
	@echo "Make targets:"
	@echo "  prod - run the Docker image with Rails running in production mode"
	@echo "  test - run rails test in the container"
	@echo "  tag - tag the image with the PREFIX"
	@echo "  release - push the image to the Docker registry"
	@echo "  clean - remove temporary files"
	@echo "  version - show the current app version"
	@echo "  tag - tag the image with the prefix"
	@echo ""
	@echo "Environment variables (optional: all variables have defaults):"
	@echo "  PREFIX"
	@echo "  IMAGE"
	@echo "  FSA_DATA_DOT_FOOD_API_URL"
	@echo "  SECRET_KEY_BASE"

image:
	docker build --tag ${IMAGE}:${APP_VERSION} .

prod: image
	docker run --rm --name data-dot-food-browser -p3000:3000 -e RAILS_ENV=production -e FSA_DATA_DOT_FOOD_API_URL=${FSA_DATA_DOT_FOOD_API_URL} -e SECRET_KEY_BASE=${SECRET_KEY_BASE} ${IMAGE}:${APP_VERSION}

test: image
	@-docker stop data-dot-food-browser 2> /dev/null || true
	@docker run -d --rm --name data-dot-food-browser -p3000:3000 -e FSA_DATA_DOT_FOOD_API_URL=${FSA_DATA_DOT_FOOD_API_URL} -e RAILS_ENV=development ${IMAGE}:${APP_VERSION}
	@docker exec -it -e FSA_DATA_DOT_FOOD_API_URL=${FSA_DATA_DOT_FOOD_API_URL} -e RAILS_ENV=test data-dot-food-browser ./bin/rails test
	@docker stop data-dot-food-browser

tag:
	@docker tag ${IMAGE}:${APP_VERSION} ${PREFIX}/${IMAGE}:${APP_VERSION}

release:
	@docker push ${PREFIX}/${IMAGE}:${APP_VERSION}

clean:
	@rake assets:clobber webpacker:clobber tmp:clear
