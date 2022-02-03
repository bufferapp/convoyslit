.DEFAULT_GOAL := run

IMAGE_NAME := gcr.io/buffer-data/convoyslit:1.0.0

GCLOUD_CONFIG_FLAG = -v $(HOME)/.config/gcloud/:/root/.config/gcloud

run:
	streamlit run app.py

docker-build:
	docker build -t $(IMAGE_NAME) .

docker-run: docker-build
	docker run -it -p 8501:8501 --rm $(IMAGE_NAME)

docker-push: docker-build
	docker push $(IMAGE_NAME)

#
# deploy: docker-push
# 	gcloud beta run services replace service.yaml --platform managed --region us-central1