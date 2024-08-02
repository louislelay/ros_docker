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
    build-essential \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    libpcl-dev \
    cmake \
    git \
    libpoco-dev \
    libeigen3-dev \
    net-tools \
    nano \
    terminator \
    wget \
    gedit \
    vim \
    python3-pip \
    python-pip \
    dbus \
    dbus-x11 \
    && rm -rf /var/lib/apt/lists/*

# install ROS useful tools
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    ros-melodic-gmapping \
    ros-melodic-map-server \
    ros-melodic-navigation \
    ros-melodic-robot-state-publisher \
    ros-melodic-move-base \
    ros-melodic-amcl \
    ros-melodic-depthimage-to-laserscan \
    ros-melodic-joy \
    ros-melodic-teleop-twist-keyboard \
    ros-melodic-openni-camera \
    ros-melodic-rqt-image-view \
    ros-melodic-rqt-controller-manager \
    ros-melodic-rqt-joint-trajectory-controller \
    ros-melodic-cv-camera \
    ros-melodic-image-view \
    ros-melodic-pcl-ros \
    ros-melodic-pcl-conversions \
    && rm -rf /var/lib/apt/lists/*

# install ROS realsense
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    ros-melodic-realsense2-camera \
    ros-melodic-realsense2-description \
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
