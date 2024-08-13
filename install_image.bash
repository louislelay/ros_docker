#!/bin/bash

# Build dockerfile
docker build --tag ros_docker \
--build-arg USER_ID=$(id -u) \
--build-arg GROUP_ID=$(id -g) .
docker image prune -f

