ARG ARCH=osrf
ARG ROS_DISTRO=melodic
ARG OS_DISTRO=bionic

FROM ${ARCH}/ros:${ROS_DISTRO}-desktop-full-${OS_DISTRO}

ARG USER_ID
ARG GROUP_ID
RUN addgroup --gid $GROUP_ID user
RUN useradd -ou 0 -g $GROUP_ID user

# install xauth for gui applications
RUN apt-get update && apt-get install -q -y --no-install-recommends \
		xauth \
		&& rm -rf /var/lib/apt/lists/*


#-----------------------------------------------------------------------------

# install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
		git \
		nano \
		terminator \
		python3-pip \
		python-pip \
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

# create catkin_ws
RUN mkdir -p /home/catkin_ws/src

#-----------------------------------------------------------------------------

# config terminator
RUN mkdir -p /root/.config/terminator

RUN echo '[global_config]\n\
	title_hide_sizetext = True\n\
[keybindings]\n\
[profiles]\n\
	[[default]]\n\
		icon_bell = False\n\
		background_color = "#300a24"\n\
		cursor_shape = ibeam\n\
		cursor_color = "#aaaaaa"\n\
		foreground_color = "#ffffff"\n\
		show_titlebar = False\n\
		rewrap_on_resize = False\n\
[layouts]\n\
	[[default]]\n\
		[[[window0]]]\n\
			type = Window\n\
			parent = ""\n\
		[[[child1]]]\n\
			type = Terminal\n\
			parent = window0\n\
[plugins]'>>/root/.config/terminator/config

# bash
COPY ./setup.bash /

RUN echo "source /setup.bash">>/root/.bashrc
RUN echo "source /home/catkin_ws/devel/setup.bash">>/root/.bashrc
RUN echo 'export PS1="\[\e[38;5;40m\]\u\[\e[38;5;15m\]@\[\e[38;5;27m\]\h\[\e[38;5;15m\]:\[\e[38;5;128m\]\w\[\033[0m\]$ "'>>/root/.bashrc
RUN echo "export NO_AT_BRIDGE=1">>/root/.bashrc
RUN echo "umask g+w">>/root/.bashrc

USER user

CMD ["bash"]
