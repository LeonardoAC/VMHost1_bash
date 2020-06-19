#!/bin/bash
#------------------------------------------------------------------------------------------
# Inicia APENAS UMA vm-w7
# Caso o parametro nao fora passado, iniciará a primeira subsequente que estiver shut off
# by Leonardo A. Carrilho
# Novembro 2018
# -----------------------------------------------------------------------------------------
# SINTAXE: sh start-one-vm-w7.sh <nome-da-vm>
# RETORNO: Id da VM
#
# Se parametro nao foi dado
if [ -z $1 ]
then
	# cria saída com Vm's desligadas
	(virsh list --all | grep 'vm-w7' | grep 'shut off') > temp
	# Retorna APENAS a primeira linha em temp
	firstvmoff=$(grep "vm-w7-" temp | grep "shut off" | head -1)
	rm -f temp
	virsh start ${firstvmoff:4:14}
else
	# Passou o nome da vm por param.
	virsh start "vm-w7-"$1
fi
