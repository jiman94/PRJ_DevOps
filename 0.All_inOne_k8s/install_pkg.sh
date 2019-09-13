#! /usr/bin/env bash

# install packages 
yum install epel-release -y
yum install git -y
yum install vim-enhanced -y
yum install docker -y && systemctl enable --now docker
yum install kubelet kubeadm kubectl -y && systemctl enable --now kubelet

