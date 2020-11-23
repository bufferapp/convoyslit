.DEFAULT_GOAL := run

IMAGE_NAME := gcr.io/buffer-data/convoyslit:0.8.0

GCLOUD_CONFIG_FLAG = -v $(HOME)/.config/gcloud/:/root/.config/gcloud

.PHONY: build
build:
	docker build -t $(IMAGE_NAME) .

.PHONY: run
run: build
	docker run -it -p 8501:8501 $(GCLOUD_CONFIG_FLAG) --rm $(IMAGE_NAME)

.PHONY: dev
dev:
	docker run -it -v $(PWD):/app -p 8501:8501 $(GCLOUD_CONFIG_FLAG) -e GOOGLE_CLOUD_PROJECT=buffer-data --rm $(IMAGE_NAME) /bin/bash

.PHONY: push
push: build
	docker push $(IMAGE_NAME)

.PHONY: deploy
deploy: push
	kubectl apply -f kubernetes/