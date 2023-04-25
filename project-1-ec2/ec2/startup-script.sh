#!/bin/bash
#
## Install kubeadm, kubectl, kubeadm, containerd - and other components and will create a running kubernetes cluster the kubeadm way
#
## Update/Upgrade
sudo yum update -y; sudo yum upgrade -y
#
## Install container runtime
sudo yum install containerd -y
#
## Run container runtime
sudo systemctl restart containerd.service
#
## Add kubernetes repository
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF
#
## Set SELinux in permissive mode (effectively disabling it)
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
#
## Install kubelet, kubeadm and kubectl
sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
#
## Enable kubelet
sudo systemctl enable --now kubelet
#
## change hostname
sudo hostnamectl set-hostname controlplane
#
## Udate hosts file
sudo bash -c "echo $(hostname -i | cut -d ' ' -f 2-;) 'controlplane'" >> /etc/hosts
#
## Enable ip forwarding
sudo bash -c "echo '1' > /proc/sys/net/ipv4/ip_forward"
#
## Install iproute package
sudo yum install iproute-tc -y
#
## Run modeprobe
sudo modprobe br_netfilterkubectl
#
## Create kubeadm cluster
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --control-plane-endpoint=controlplane --apiserver-advertise-address=$(ip a | grep eth0 -A4 | grep inet | awk '{ print $2 }' | grep -v "\:" | sed 's/...$//')
#
## Set configuration file
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
#
## Install network plugin
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
#
## Create join token for other worker nodes to join
kubeadm token create --print-join-command