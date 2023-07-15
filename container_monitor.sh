#!/bin/bash

IMAGE_NAME="code_docker_jupyter_image"

while true; do
    # Find the container ID by filtering based on image name
    CONTAINER_ID=$(docker ps -qf "ancestor=$IMAGE_NAME")

    echo "Monitoring"
    if [ -n "$CONTAINER_ID" ]; then
        # Get the container's start time in epoch format
        START_TIME=$(docker inspect -f '{{.State.StartedAt}}' $CONTAINER_ID)
        START_TIMESTAMP=$(date -d $START_TIME +%s)

        # Calculate the running duration
        CURRENT_TIMESTAMP=$(date +%s)
        RUNNING_SECONDS=$((CURRENT_TIMESTAMP - START_TIMESTAMP))

        # Check if the running duration is greater than 80 seconds
        if [ $RUNNING_SECONDS -gt 80 ]; then
            # Stop the container
            docker stop $CONTAINER_ID
            echo "Container $CONTAINER_ID stopped."
        fi
    fi

    # Wait for 60 seconds before checking again
    sleep 180
done