#!/bin/bash
#------------------------------------------------------------------------------------------
# Inicia APENAS UMA cloudera
# Caso o parametro nao fora passado, iniciará a primeira subsequente que estiver shut off
# by Leonardo A. Carrilho
# Fevereiro 2020
# -----------------------------------------------------------------------------------------
# SINTAXE: sh start-one-cloudera.sh <nome-da-vm>
# RETORNO: Id da VM
#
# Se parametro nao foi dado
if [ -z $1 ]
then
	# cria a saída com a 1ª Vm em estado "shut off"
	# Retorna APENAS a primeira linha da consulta com a ocorrência desejada
	saida=$(virsh list --all | grep 'cloudera' | grep 'shut off' | head -1)
	vmParaSubir=${saida:7:12}
	# starta a Vm:
	virsh start $vmParaSubir
	# debug
	#clear
	#echo $vmParaSubir
else
	# Passou o nome da vm por param.
	virsh start "cloudera"$1
	#debug
	#echo "Passou parametro $i"
fi
