#!/bin/bash
#--------------------------------
# Inicia TODAS as vm-w7
# by Leonardo A. Carrilho
# Novembro 2018
# -------------------------------
# SINTAXE: sh start-vm-w7.sh <qtde-vm's>

# Caminho das VM's w7
path=host/vm/images/lab

# confere se parametro nao está vazio
if [ ! -z $1 ]
then
	for (( maq=0; maq<=$1; maq++ ))
		do
			# Monta o nome das máquinas
			if test $maq -lt 10
		        then
		            	nomedaVM=vm-w7-0$maq
		        else
		            	nomedaVM=vm-w7-$maq
		        fi
			# Starta as Vm's do Láb.
			virsh start $nomedaVM
		done
		clear
		echo "LISTA DE TODAS AS VM's"
		virsh list --all
else
	echo "A Sintaxe correta é: sh start-vm-w7.sh <qtde-vm>"
fi
