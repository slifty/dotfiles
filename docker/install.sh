###
# We want to use Docker without using Docker Desktop.  This means using minikube too.
# These steps are described in more detail at:
# https://dhwaneetbhatt.com/blog/run-docker-without-docker-desktop-on-macos
###

# Start minikube
minikube start
# Tell Docker CLI to talk to minikube's VM
eval $(minikube docker-env)
# Set up the custom host
echo "`minikube ip` docker.local" | sudo tee -a /etc/hosts > /dev/null
