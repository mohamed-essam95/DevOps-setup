## Setup Git
sudo apt-get update
sudo apt-get install -y git
git config --global user.name "mohamed-essam95"
git config --global user.email "mohamed.essam955559@gmail.com"

#----------------------------------#

## Setup Ansible
sudo apt update
sudo apt install ansible -y
ansible --version

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

# To install a specific version, list the available versions in the repo, then select and install:
sudo systemctl status docker
sudo systemctl start docker

# Verify that Docker Engine is installed correctly by running the hello-world image:
sudo docker run hello-world

# To avoid using `sudo` with the `docker` command, add your user to the `docker` group:
sudo usermod -aG docker $USER

#----------------------------------#

## Setup Terraform
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform