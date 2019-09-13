#! /usr/bin/env bash

#Init kubernetes 
kubeadm init --token 123456.1234567890123456 --pod-network-cidr=172.16.0.0/16 --apiserver-advertise-address=192.168.1.10 

#config for master node only 
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

#config for kubernetes's network 
#kubectl apply -f https://docs.projectcalico.org/master/manifests/calico.yaml
#kubectl apply -f https://git.io/JeB46 #CIDR=10.10.0.0/16
kubectl apply -f https://git.io/JeBXF #CIDR=172.16.0.0/16
#kubectl label node w1-k8s  node-role.kubernetes.io/worker=worker
#kubectl label node w2-k8s  node-role.kubernetes.io/worker=worker
#kubectl label node w3-k8s  node-role.kubernetes.io/worker=worker


#CIDR을 양쪽을 변경해야만 10.10.0.0/16이 적용됨 둘다 안 넣어주면 192.168.0.0/16 default로 동작 
############ 잘되는 조합 ######################## 
#kubectl apply -f https://git.io/JeB46 #CIDR=10.10.0.0/16 
#kubeadm init --token 123456.1234567890123456 --pod-network-cidr=10.10.0.0/16 --apiserver-advertise-address=192.168.1.10 
