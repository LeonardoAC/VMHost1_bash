#!/bin/bash
#-----------------------------------------------
# Clona a matriz cloudera em várias VM's
# By Leonardo A. Carrilho
# Janeiro de 2020
#-----------------------------------------------
# SINTAXE: sh clona-vm-cloudera.sh <qtde-vm-a-serem-criadas>

# Caminho onde ficarao as VM's
path=/home/vm/images/lab

# nome da matriz
MATRIZ=cloudera

# Se o parametro não está vazio
if [ ! -z $1 ]
then
	# Desliga VM Matriz caso esteja running (obrigatório)
	state=$(virsh domstate $MATRIZ)
	if [ $state == "running" ] 
	then 
		virsh destroy $MATRIZ
	fi
	for (( maq=0; maq<=$1; maq++ ))
	do
		# Trata o zero à esquerda do nome
		if test $maq -lt 10
		then
			nomedaVM=vm-cloudera-0$maq
		else
			nomedaVM=vm-cloudera-$maq
		fi
		
		# Comando para clonar
		virt-clone --original $MATRIZ --name $nomedaVM --file $path/$nomedaVM.img
		# feedback ao user
		clear
		echo Clonando maquina ${nomedaVM} [ $maq de $1 ]
		echo Aguarde...
	done
else
	echo "Sintaxe correta é: sh "$0" <qtde-vm-a-serem-criadas>"
fi
