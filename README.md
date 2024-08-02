# ROS Melodic Docker Setup

This setup provides a Docker container for ROS (Robot Operating System) Melodic with a full desktop environment, ideal for robotic development and simulation.

**Prerequisites**: Ensure Docker is installed on your system before proceeding. Instructions for installing Docker are provided at the end of this document.

## Getting Started

1. **Install the Docker Image**:  
   Run the following command to install the Docker image:  
   ```bash
   ./install_image.bash
   ```

2. **Start the Docker Container**:  
   Launch the Docker container using this command:  
   ```bash
   ./start_docker.bash
   ```

3. **Exit the Docker Container**:  
   To exit the container, type `exit`.

## Workspace Setup

The `home` directory is shared between your computer and the Docker container, ensuring that files persist after you exit the container. To set up your ROS workspace:

1. Create a `catkin_ws` directory inside the `home` folder.
2. Inside `catkin_ws`, create a `src` directory.
3. You can now develop ROS packages within the `src` folder.

## Installing Additional Features

Changes made within the Docker container are temporary. To make changes permanent:

1. Add the required installation commands to the `Dockerfile`.
2. Rebuild the Docker image by running:  
   ```bash
   ./install_image.bash
   ```

## Docker Installation Instructions

1. **Remove Old Docker Packages**:
   ```bash
   sudo apt-get remove -y docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc
   ```

2. **Update Package List**:
   ```bash
   sudo apt-get update
   ```

3. **Install Essential Packages**:
   ```bash
   sudo apt-get install -y ca-certificates curl gnupg
   ```

4. **Add Docker’s Official GPG Key**:
   ```bash
   sudo install -m 0755 -d /etc/apt/keyrings
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
   sudo chmod a+r /etc/apt/keyrings/docker.gpg
   ```

5. **Set Up Docker Repository**:
   ```bash
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   ```

6. **Update Package List Again**:
   ```bash
   sudo apt-get update
   ```

7. **Install Docker**:
   ```bash
   sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
   ```

8. **Run Docker Without Sudo**:
   ```bash
   sudo groupadd docker
   sudo usermod -aG docker $USER
   newgrp docker
   ```

9. **Verify Docker Installation**:
   ```bash
   docker run hello-world
   ```

## Uninstalling Docker and Cleaning Up

1. **Uninstall Docker Packages**:
   ```bash
   sudo apt-get purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
   ```

2. **Remove Docker Data**:
   ```bash
   sudo rm -rf /var/lib/docker
   sudo rm -rf /var/lib/containerd
   ```