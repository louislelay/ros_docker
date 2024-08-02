---

# ros_melodic_docker

A Docker setup for ROS (Robot Operating System) Melodic with a full desktop environment. This setup provides a ready-to-use development and simulation environment for robotic applications.

**Prerequisites**: Ensure that Docker is installed on your system before proceeding with the setup. Docker is required to run the provided containerized environment.

## Getting Started

1. **Install the Docker Image**:  
   Run the following command to install the Docker image:  
   ```bash
   ./install_image.bash
   ```

2. **Launch the Docker Container**:  
   Start the Docker container with the command:  
   ```bash
   ./start_docker.bash
   ```

3. **Exit the Docker Container**:  
   To exit the container, simply type `exit`.

## Workspace Setup

The `home` folder is a shared directory between your computer and the Docker container. Files placed here will persist even after exiting the container. To set up your ROS workspace:

1. Inside the `home` folder, create a `catkin_ws` folder.  
2. Within `catkin_ws`, create a `src` folder.  
3. You can start developing ROS packages inside the `src` folder.

## Installing New Features

If you need to install additional features or packages, note that changes made inside the Docker container will be lost once you exit. To make these changes permanent:

1. Add the necessary commands to the `Dockerfile`.
2. Rebuild the Docker image by running:  
   ```bash
   ./install_image.bash
   ```

---
