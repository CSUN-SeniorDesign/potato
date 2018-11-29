# Docker for Automation Testing

### Installing Docker
1. Update the package list and install required software.

  ```
  sudo apt update && \
  sudo apt install linux-image-extra-$(uname -r) linux-image-extra-virtual apt-transport-https ca-certificates curl software-properties-common
  ```

2. Add GPG key to the Docker repository then add it to APT sources.

  ```
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
  ```

3. Update the package list again and make sure to download from docker repository rather than ubuntu. Then install docker.

  ```
  sudo apt update && \
  apt-cache policy docker-ce && \
  sudo apt install docker-ce
  ```

4. Add the user to the docker group to avoid having to use sudo on every command.

  ```
  sudo usermod -aG docker ${USER}
  ```
  or
  ```
  sudo -i && \
  sudo usermod -aG docker username
  ```

### Setting up Docker for the first use
1. Run the command to check which version of ubuntu to download.

  ```
  docker search ubuntu
  ```

2. Once you know which version you want, install it using the pull command.

  ```
  docker pull nameOfImage
  ```

### Creating a Docker image using a Dockerfile
1. First start by creating a new directory for the Dockerfile.

2. Use an editor to create the Dockerfile

  ```
  nano Dockerfile
  ```

3. Start the Dockerfile with the ```FROM``` command that uses an operating system as a base.

  ```
  FROM ubuntu:18.04
  ```

4. Use the ```RUN``` command to run the linux command to download and install software

  ```
  RUN apt-get -y install apache2
  RUN ./home/install.sh
  ```

5. Use the ```COPY``` command to move files form the host machine

  ```
  COPY install.sh /home/install.sh
  ```

6. Once you've finished adding commands to the Dockerfile, build the Docker image.

  ```
  docker build -f image-name -t tagid [path/from/root/to/image]

  docker build /path/to/Dockerfile -t image-name
  docker build - < /path/to/Dockerfile -t image-name
  ```

  example:

  ```
  docker build -t docker-test -t 1.0 ~/Desktop/docker-test

  docker build --rm=true -t production-site .
  ```

7. Remove a docker image. As long as a couple unique characters from the image id is used, the command will find the entire id and remove it for you.

    ```
    docker rmi [imageid]
    ```

### Creating/Running/Managing a Docker containers/images.
1. Check which images you have.

  ```
  docker images
  ```

2. Run the image as a container interactively (Using a shell).

  ```
  docker run -it nameOfImage
  ```

3. Run the image as a container non-interactively.

  ```
  docker run -t -d nameOfImage
  ```

4. Start and stop a container.

  ```
  docker start containerID
  docker stop containerID

  # Stopping all docker containers
  docker stop $(docker ps -aq)
  ```

5. Manage containers.

  ```
  # Check all active and inactive containers.
  docker ps -a

  # Remove a stopped container.
  docker rm containerID

  # Removing all docker containers.
  docker rm $(docker ps -aq)
  ```

6. Manage images

  ```
  docker rmi imageID

  # Remove all images
  docker rmi $(docker images -q)
  ```
