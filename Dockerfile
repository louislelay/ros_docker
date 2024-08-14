ARG ARCH=osrf
ARG ROS_DISTRO=kinetic

FROM ${ARCH}/ros:${ROS_DISTRO}-desktop-full

ARG USER_ID
ARG GROUP_ID
RUN addgroup --gid $GROUP_ID user
RUN useradd -ou 0 -g $GROUP_ID user

# install xauth for gui applications
RUN apt-get update && apt-get install -q -y --no-install-recommends \
		xauth \
		&& rm -rf /var/lib/apt/lists/*


#---- Add your modifications below to add the functionnality you need ----

# install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    net-tools \
    nano \
    terminator \
    && rm -rf /var/lib/apt/lists/*

# install python packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# install ROS useful tools
RUN apt-get update && apt-get install -q -y --no-install-recommends \
		ros-${ROS_DISTRO}-gmapping \
		ros-${ROS_DISTRO}-map-server \
		ros-${ROS_DISTRO}-navigation \
		ros-${ROS_DISTRO}-robot-state-publisher \
		ros-${ROS_DISTRO}-move-base \
		ros-${ROS_DISTRO}-amcl \
		ros-${ROS_DISTRO}-depthimage-to-laserscan \
		ros-${ROS_DISTRO}-joy \
		ros-${ROS_DISTRO}-teleop-twist-keyboard \
		ros-${ROS_DISTRO}-openni-camera \
		ros-${ROS_DISTRO}-rqt-image-view \
		&& rm -rf /var/lib/apt/lists/*

#-----------------------------------------------------------------------------

# bash
COPY ./setup.bash /

RUN echo "source /setup.bash">>/root/.bashrc
RUN echo "source /home/catkin_ws/devel/setup.bash">>/root/.bashrc
RUN echo 'export PS1="\[\e[38;5;40m\]\u\[\e[38;5;15m\]@\[\e[38;5;27m\]\h\[\e[38;5;15m\]:\[\e[38;5;128m\]\w\[\033[0m\]$ "'>>/root/.bashrc
RUN echo "export NO_AT_BRIDGE=1">>/root/.bashrc
RUN echo "umask g+w">>/root/.bashrc

USER user

CMD ["bash"]
