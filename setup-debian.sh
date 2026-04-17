#!/bin/bash

## Setup Git
sudo apt-get update
sudo apt-get install -y git
git config --global user.name "mohamed-essam95"
git config --global user.email "mohamed.essam955559@gmail.com"

#----------------------------------#

## Setup GitHub CLI
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

sudo apt update
sudo apt install gh -y

#----------------------------------#

## Setup Ansible
sudo apt update
sudo apt install ansible -y
ansible --version

## Setup Ansible Lint
sudo apt update
sudo apt install ansible-lint -y
ansible-lint --version

#----------------------------------#

## Setup Docker
# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update

# To install the latest version, run:
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Verify that Docker Engine is installed correctly by running the hello-world image:
sudo docker run hello-world

# To avoid using `sudo` with the `docker` command, add your user to the `docker` group:
sudo usermod -aG docker $USER

#----------------------------------#

## Setup kubectl
# 1- Update the apt package index and install packages needed to use the Kubernetes apt repository:
  sudo apt-get update
  # apt-transport-https may be a dummy package; if so, you can skip that package
  sudo apt-get install -y apt-transport-https ca-certificates curl gnupg

# 2- Download the Google Cloud public signing key:
  # If the folder `/etc/apt/keyrings` does not exist, it should be created before the curl command, read the note below.
  # sudo mkdir -p -m 755 /etc/apt/keyrings
  curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.35/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
  sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg # allow unprivileged APT programs to read this keyring

# 3- Add the appropriate Kubernetes apt repository. If you want to use Kubernetes version different than v1.35, replace v1.35 with the desired minor version in the command below:
  # This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
  echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.35/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
  sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list   # helps tools such as command-not-found to work correctly

# 4- Update apt package index, then install kubectl:
  sudo apt-get update
  sudo apt-get install -y kubectl

#----------------------------------#
## Setup Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb

#----------------------------------#

## Setup AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

#----------------------------------#

## Setup Terraform
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

#----------------------------------#
