#!/usr/bin/env bash
set -e
source ~/.dotfiles/lib/functions.sh

###
# We want to use Docker without using Docker Desktop. This means using minikube too.
# These steps are described in more detail at:
# https://dhwaneetbhatt.com/blog/run-docker-without-docker-desktop-on-macos
###

check_command minikube

info "Starting minikube"
minikube start --mount --mount-string="${HOME}/Maestral/Code:/data/Code"

info "Enabling ingress addon"
minikube addons enable ingress

info "Setting up docker environment"
eval $(minikube docker-env)

info "Adding docker.local to /etc/hosts"
# docker.local points at minikube's dynamic IP, so it lives outside the hosts/
# managed block. Remove any prior entry first so re-runs don't duplicate it.
sudo sed -i '' '/[[:space:]]docker\.local$/d' /etc/hosts
echo "$(minikube ip) docker.local" | sudo tee -a /etc/hosts > /dev/null

success "Docker environment configured"
