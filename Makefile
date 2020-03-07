
build:
	docker build . -t raspotify-docker:armhf-buster
	docker tag raspotify-docker:armhf-buster piotrb/raspotify-docker:armhf-buster

push:
	docker push piotrb/raspotify-docker:armhf-buster

install:
	sudo install -m 644 -o root -g root raspotify-docker.service /lib/systemd/system/
	sudo systemctl enable raspotify-docker

run:
	docker run \
		--net=host \
		--rm \
		-it \
		--device /dev/snd \
		-e DEVICE_NAME="raspotify docker" \
		-e BITRATE=320 \
		piotrb/raspotify-docker:armhf-buster
