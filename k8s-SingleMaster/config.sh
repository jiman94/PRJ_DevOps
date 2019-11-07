#! /usr/bin/env bash

# vim configuration 
echo 'alias vi=vim' >> /etc/profile

# swapoff -a to disable swapping
swapoff -a
# sed to comment the swap partition in /etc/fstab
sed -i.bak -r 's/(.+ swap .+)/#\1/' /etc/fstab


cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

# Set SELinux in permissive mode (effectively disabling it)
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

# Some users on RHEL/CentOS 7 have reported issues with traffic being routed incorrectly due to iptables being bypassed
cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

modprobe br_netfilter

# local small dns 
cat <<EOF >  /etc/hosts
192.168.1.10 m-k8s 
192.168.1.101 w1-k8s
192.168.1.102 w2-k8s
192.168.1.103 w3-k8s
EOF

# config DNS  
cat <<EOF > /etc/resolv.conf
nameserver 1.1.1.1
nameserver 8.8.8.8 #Google DNS
nameserver 168.126.63.1 #KT DNS
EOF