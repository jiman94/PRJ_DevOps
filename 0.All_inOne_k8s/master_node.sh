#! /usr/bin/env bash

#Init kubernetes 
kubeadm init --token 123456.1234567890123456 --apiserver-advertise-address=192.168.1.10

#config for master node only 
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
#chown $(id -u):$(id -g) $HOME/.kube/config

#config for kubernetes's network 
kubectl apply -f \
https://docs.projectcalico.org/v3.1/getting-started/kubernetes/installation/hosted/kubeadm/1.7/calico.yaml
