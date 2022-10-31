#!/bin/bash
#
# Cleanup RKE/Rancher and all remnants
#
if [[ $EUID -ne 0 ]] ; then
    clear;echo -e "\nYou probably want to run this as root?\n"
    echo -e "Become root and try this again.\n"
    exit 1
fi

echo -e "\nWARNING: This WILL destroy your Docker/Rancher environment\n"

read -p "Are you sure you want to continue? " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

clear

docker stop "$(docker container ls -q)"

docker system prune -f -a --volumes

rm -rf /etc/ceph \
       /etc/cni \
       /etc/kubernetes \
       /opt/cni \
       /opt/rke \
       /opt/containerd \
       /opt/rancher \
       /run/secrets/kubernetes.io \
       /run/calico \
       /run/flannel \
       /var/lib/calico \
       /var/lib/etcd \
       /var/lib/cni \
       /var/lib/kubelet \
       /var/lib/rancher/rke/log \
       /var/log/containers \
       /var/log/pods \
       /var/run/calico
