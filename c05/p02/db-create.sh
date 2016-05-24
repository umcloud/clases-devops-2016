#!/bin/bash
set -e
name=c05-${USER}-db
grep -q USUARIO db.yaml  && { echo "ERROR:  tenes que editar USUARIO con tu nombre en el yaml"; exit 1; }
cloud_init_file="db.yaml"
image=$(nova image-list | awk '/xenial.*disk1.img/{ print $4 }')
flavor=m1.small
net_id=$(nova net-list | awk '/net_umstack/{ print $2 }')
set -x
nova boot --image ${image} --nic net-id="${net_id}" --flavor ${flavor} --user-data ${cloud_init_file} "$@" ${name}