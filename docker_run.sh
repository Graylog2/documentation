#!/usr/bin/env bash

THIS_DIR=$(cd `dirname $0`; pwd -P)
DOCKER_IMAGE_NAME="graylog/documentation"
DOCKER_CONTAINER_NAME="graylog-documentation"

function exit_error {
    message="${1}"
    echo -e "\n\033[31mERROR: $message\033[0m" >/dev/stderr
    exit 1
}

# check if Docker is installed
which docker >/dev/null
if [[ $? != 0 ]] ; then
    exit_error "Docker does not seem to be installed (or resides in an unusual path). Please fix that first."
fi

# if the image is running ask to stop 
docker ps | grep -qw ${DOCKER_CONTAINER_NAME}
if [[ $? == 0 ]] ; then
	read -p "Graylog documentation Docker container running, Stop? (y/n)" -n 1 -r
	echo    # (optional) move to a new line
	if [[ $REPLY =~ ^[Yy]$ ]] ; then
    
		# stop 
	    docker stop ${DOCKER_CONTAINER_NAME}

	    if [[ $? == 0 ]] ; then
			read -p "remove the Graylog documentation Docker image? (y/n)" -n 1 -r
				echo    # (optional) move to a new line
				if [[ $REPLY =~ ^[Yy]$ ]] ; then
	    			docker rmi ${DOCKER_IMAGE_NAME}	  
	   			 	exit 0
				fi
		fi

	exit 0
	fi

	echo "no action needed."
	echo "connect to the Graylog Docker container"
	echo "defaults to http://127.0.0.1:8000"
	exit 0
fi

# check if Docker image is present, otherwise build it
docker images | grep -qw ${DOCKER_IMAGE_NAME}
if [[ $? != 0 ]] ; then
	echo "Docker image not found, will build it now"
    docker build -t ${DOCKER_IMAGE_NAME} -f ${THIS_DIR}/Dockerfile  . && echo "Done"
fi

# read additional environment variables from .env, if present
[[ -e ${THIS_DIR}/.env ]] && source ${THIS_DIR}/.env

# check if Docker container is present, otherwise make the first start with all arguments
docker ps -a | grep -qw ${DOCKER_CONTAINER_NAME}
if [[ $? != 0 ]] ; then
	echo "Docker starting:"
    docker run -it -d --rm -v "${THIS_DIR}":/web -u $(id -u):$(id -g) -p 8000:8000 --name ${DOCKER_CONTAINER_NAME} ${DOCKER_IMAGE_NAME}
 	
 	echo "Graylog documentation Docker container created,"
 	echo "defaults to http://127.0.0.1:8000"
 	exit 0
fi

# now the normal start should be possible, but we will check
docker images | grep -qw ${DOCKER_CONTAINER_NAME}
if [[ $? == 0 ]] ; then
	echo "Starting the Docker container, will be serving on http://127.0.0.1:8000 by default"
    docker start graylog-documentation
    exit 0
fi

exit_error "we should never reach this point!"
