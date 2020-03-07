
REMOTE_IMAGE_REF=piotrb/raspotify-docker:latest

build:
	docker build . -t piotrb/raspotify-docker:armhf-buster
push:
	docker push piotrb/raspotify-docker:armhf-buster
	docker manifest create ${REMOTE_IMAGE_REF} piotrb/raspotify-docker:armhf-buster
	docker manifest annotate ${REMOTE_IMAGE_REF} piotrb/raspotify-docker:armhf-buster --os linux --arch arm --variant buster
	docker manifest push --purge ${REMOTE_IMAGE_REF}

install:
	sudo install -m 644 -o root -g root lib/systemd/system/raspotify-docker.service /lib/systemd/system/raspotify-docker.service
	sudo install -m 644 -o root -g root etc/default/raspotify-docker /etc/default/raspotify-docker
	sudo systemctl daemon-reload
	sudo systemctl enable raspotify-docker
	sudo systemctl start raspotify-docker

run:
	docker run \
		--net=host \
		--rm \
		-it \
		--device /dev/snd \
		-e DEVICE_NAME="raspotify docker" \
		-e BITRATE=320 \
		${REMOTE_IMAGE_REF}
