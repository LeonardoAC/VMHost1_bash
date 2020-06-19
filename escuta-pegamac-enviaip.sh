#!/bin/sh
# Leonardo A. Carrilho
# 03 de setembro de 2019
#
# -------------------------------------------------------------------
# Funciona como um pequeno servidor, escutando pedidos de IP das Vm`s
# -------------------------------------------------------------------
#
# 

# Abre conexao de escuta
# recebe o MAC Address do client
ncat -vl 10000 > temp

# Extrai o MAC do cliente
MAC=$(cat temp | grep -oE "([0-9a-fA-F]{2}[:]){5}[0-9a-fA-F]{2}")

# Extrai o IP do cliente
IPClient=$(cat temp | grep -oE "([0-9]{1,3}[.]){3}[0-9]{1,3}")

# deleta temp
rm -f temp

# recebe o ID da VM (a primeira shut off da lista)
x=$(virsh list --all |grep -i "vm-w7" |grep -i "shut off" | head -1)
VM=${x:4:12}

# Envia MAC client, ID da VM e retorna o IP da VM
# O script chamado vai ligar a VM 
(/bin/sh /home/vm/images/bind-mac-ip-start.sh $MAC $VM) > retorna-ip

# debug
echo "[escuta] client MAC -> "$MAC
echo "[escuta] client IP -> "$IPClient
echo "[escuta] ID da VM, status e  IP de acesso (abaixo):"
cat retorna-ip

# Abre conexao de envio
# Envia o IP da VM para o client
cat retorna-ip | ncat $IPClient -p 10001

# deleta o file
rm -f retorna-ip
