#!/bin/bash

container_name=TIAGo
image_name=tiago-docker

xhost +local:

echo " "
echo "Starting docker engine..."
systemctl start docker

echo " "
echo "Building ${container_name} docker..."
docker build -f tiago_docker/Dockerfile -t ${image_name} .

echo " "
echo "Running docker container..."
docker run --name ${container_name} -it --rm --network host -e DISPLAY=$DISPLAY -e NVIDIA_DRIVER_CAPABILITIES=all -e QT_X11_NO_MITSHM=1 -v $HOME/.Xauthority:/root/.Xauthority:rw -v /tmp/.X11-unix:/tmp/.X11-unix ${image_name} --privileged --gpus all

echo " "
echo "Closing docker container..."
xhost -local: