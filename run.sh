docker run \
  --net=host \
  --rm \
  -it \
  --device /dev/snd \
  -e DEVICE_NAME=Soundbar2 \
  -e BITRATE=320 \
  raspotify-docker
