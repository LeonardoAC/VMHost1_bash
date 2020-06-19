#!/bin/bash -x
# ------------------------------------------------
# Leonardo A. Carrilho
# 02/05/2018
# Script para criação de VM's usando libvirt
# -----------------------------------------------

# Set as variáveis abaixo
VMNome=<nome-da-img-a-ser-criada>
qtdeRam=<qtde-ram-xxxx>
qtdeProcessador=2
PORT=<porta>
caminhoImagem=/home/vm/images/lab/
tamanhoHD=20
tipoSO=linux
template=centos7.0
#pathMontagem=/mnt/dvd
pathMontagem=/home/vm/images/iso/<nome-da-iso>

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



