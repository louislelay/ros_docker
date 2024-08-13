#!/bin/bash

docker run -it --rm \
--env="DISPLAY" \
--env="QT_X11_NO_MITSHM=1" \
--env="LIBGL_ALWAYS_SOFTWARE=1" \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
--volume="$XAUTHORITY:/dot.Xauthority" \
--mount type=bind,source="$(pwd)"/home,target=/home \
--mount type=bind,source=/dev,target=/dev \
--privileged \
--net="host" \
--name="ros_docker" \
--workdir="/home" \
ros_docker
