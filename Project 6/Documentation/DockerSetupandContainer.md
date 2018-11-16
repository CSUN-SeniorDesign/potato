# Docker Container Setup
A container is a standard unit of software that packages up code and all its dependencies so the application runs quickly and reliably from one computing environment to another. A Docker container image is a lightweight, standalone, executable package of software that includes everything needed to run an application: code, runtime, system tools, system libraries and settings.


## Overview:
By the end of this guide the user will be able to deploy a container with Hugo and Nginx images.

## Prerequisites:

•   A Ubuntu machine

•   Docker installed


## Guide:
### Pre-Requisites

To be able to use and run any container you're going to need to install Docker on your Ubuntu machine. You'll want to update Ubuntu before installing Docker so we are using the most up to date software.

To begin we will be in root.
~~~
Sudo su
~~~

 Then run the "update" and upgrade" to grab the updates needed.
~~~
apt-get update
apt-get upgrade
~~~

After upgrading we are now able to install Docker. To do so we will run this command.
~~~
apt-get install -y docker.io
~~~

The previous command will install Docker but we will want Docker to run when our machine boots. To do this we will run the command

~~~
systemctl start docker
systemctl enable docker
~~~

Now we have Docker and it will run whenever we boot our machine up. We can now begin working on our containers.

### Docker installation Check and Test

Before we begin building the container that would contain Hugo and Nginx we will want to check if our Docker was installed properly. If you haven't already done so you can follow the documentation provided by Docker for a tutorial and check to do your first container : https://docs.docker.com/get-started/

To do the check for Docker and see if it works properly we will grab a container called "hello-world"

To check your version to see if Docker is installed run:
~~~
docker --version
~~~
Output should be Dockers version and build. Running "docker info" will provide you with additional information of your Docker installation.

To download and test Docker run:
~~~
docker run hello-world
~~~

This will download an image that isn't found locally from a public repository from the https://hub.docker.com/
You can check the images on your local machine after downloading:
~~~
docker image ls
~~~
You should then see the image "hello-world" that we just downloaded. We will then run it to see if Docker can properly do so.
~~~
docker run hello-world
~~~
If it properly runs you're ready to begin with the rest of this tutorial, otherwise you will need to troubleshoot and fix Docker.

### Docker Containers
Creating a docker container is simple and straight forward. You will need to be in a directory where you want your Dockerfile to be. The Dockerfile is the file that will contain your instructions on what you want your container to consist of.

```
vim Dockerfile
```
This will create your Dockerfile and will put you in the environment where you can begin to add what you need to your container.

The first line of your Dockerfile will be your image. This image is the base image where your will get your resources to run the other applications of your container. In this example we will use alpine:3.7. So the first line will be :

```
FROM alpine:3.7
```

Afterwards using the "RUN" command you can begin giving your container some instructions. If we wanted to add "GIT" package we would install it like we would if we were on an alpine machine.

```
RUN apk add "git"

RUN git --version
```
Using the run command is like running a line of command line code except docker is doing it for you. So in this instance we are installing the GIT package and checking to see if it was installed correctly with the version check.
