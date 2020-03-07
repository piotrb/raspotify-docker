
build:
	docker build . -t raspotify-docker:armhf-buster

push:
	docker tag raspotify-docker:armhf-buster piotrb/raspotify-docker:armhf-buster
	docker push piotrb/raspotify-docker:armhf-buster

install:


run:
	docker run \
		--net=host \
		--rm \
		-it \
		--device /dev/snd \
		-e DEVICE_NAME="raspotify docker" \
		-e BITRATE=320 \
		piotrb/raspotify-docker:armhf-buster
