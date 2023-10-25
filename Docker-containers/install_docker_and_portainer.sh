#!/bin/bash

#last update 06/05/2021

#install docker 
#Src : https://docs.docker.com/engine/install/debian/
apt update && apt upgrade -y
apt-get remove docker docker-engine docker.io containerd runc
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
	
	
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
apt install docker-compose -y
sudo usermod -aG docker $(id -u -n)
newgrp docker





#For use portainer with ssl, you must install openssl and generate certs.

#Install openssl and generate certs.
$path_to_certs_openssl = /path/to/cert_ssl_portainer

apt-get install openssl
cd $path_to_certs_openssl
openssl genrsa -out portainer.key 2048
openssl ecparam -genkey -name secp384r1 -out portainer.key
openssl req -new -x509 -sha256 -key portainer.key -out portainer.crt -days 3650

#don't forget to modify config path and certs

#create portainer
$path_to_portainer_config = /path/to/config

docker run -d -p 4443:9000 --name portainer --restart always -v "/var/run/docker.sock:/var/run/docker.sock" -v $path_to_certs_openssl:/certs -v $path_to_portainer_config:/data portainer/portainer --ssl
