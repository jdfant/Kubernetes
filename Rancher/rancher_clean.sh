#!/bin/bash
#
# Cleanup Rancher and all remnants
#
if [[ $EUID -ne 0 ]] ; then
    clear;echo -e "\nYou probably want to run this as root?\n"
    echo -e "Become root and try this again.\n"
    exit 1
fi
    
docker stop $(docker ps -qa)
docker rm -f $(docker ps -qa)
docker volume rm $(docker volume ls -qf dangling=true)
docker volume rm $(docker volume ls -q)
docker network prune
docker system prune

docker rmi $(docker images -q)
docker rm $(docker ps -q)

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
