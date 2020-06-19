#!/bin/bash -x
# ----------------------------------------------
# Leonardo A. Carrilho
# 02/05/2018
# Script para criação de VM's usando libvirt
# ----------------------------------------------
# Set as variáveis abaixo
VMNome=ojs
qtdeRam=2048
qtdeProcessador=1
PORT=5999
caminhoImagem=/home/vm/images/ti
tamanhoHD=20
tipoSO=ubuntu
template=ubuntu16.04
#pathMontagem=/mnt/dvd
pathMontagem=/home/vm/images/iso/ubuntu1604/ubuntu1604.iso

# NAO ALTERE NADA ABAIXO
virt-install \
--connect qemu:///system \
--name $VMNome \
--ram $qtdeRam \
--vcpus=$qtdeProcessador \
--disk path=$caminhoImagem/$VMNome.img,size=$tamanhoHD \
--graphics vnc,port=$PORT,listen=0.0.0.0 \
--noautoconsole \
--os-type $tipoSO \
--os-variant $template \
--accelerate \
--network=bridge:virbr0 \
--hvm \
--cdrom $pathMontagem
#--location $pathMontagem



