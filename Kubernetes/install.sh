# Definition : https://devopssec.fr/article/differents-objets-composants-kubernetes

make on kali linux 2023

For run command in k8 clusters, kubectl : https://kubernetes.io/docs/reference/kubectl/kubectl/


Install k8s : https://kubernetes.io/releases/download/
For 1.27 version.


##### install from curl ######
curl -Ls "https://sbom.k8s.io/$(curl -Ls https://dl.k8s.io/release/stable.txt)/release"| grep "SPDXID: SPDXRef-Package-registry.k8s.io"|  grep -v sha256 | cut -d- -f3- | sed 's/-/\//'| sed 's/-v1/:v1/'
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"   


We set kubectl for account administer containers : 
chmod +x kubectl
mkdir -p ~/.local/bin
mv ./kubectl ~/.local/bin/kubectl


Check version : 
kubectl version --client


 ##### install from package manager ####
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo apt-get install -y apt-transport-https
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg
echo"deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main"| sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install kubectl

#if error of install (if kali) , go : apt install kubernetes-clientkali



Make kube config file 
We can use for : 
• A running kubelet might authenticate using certificates.
• A user might authenticate using tokens.
• Administrators might have sets of certificates that they provide to individual users.

Nice tutorial : https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#config 



Create environnement :
We change registery and install all bazaar through kind on a docker, permit an architecture like :

image : Kubernetes kind architecture objective.png


Install of docker (https://github.com/doyo4400/cheap_tips_for_newbie_admin/blob/main/Docker-containers/install_docker_and_portainer.sh)
sudo apt install gccgo-go -y
go install sigs.k8s.io/kind@v0.20.0 && kind create cluster
sudo cp -s /home/$USER/go/bin/kind /usr/bin/kind 


from url <https://kind.sigs.k8s.io/> 

