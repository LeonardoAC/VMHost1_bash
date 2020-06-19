#!/bin/bash
#-----------------------------------------------
# Clona a matriz windows 7 em várias VM's
# By Leonardo A. Carrilho
# Dezembro de 2018
#-----------------------------------------------
# SINTAXE: sh clona-vm-w7.sh <qtde-vm-a-serem-criadas>

# Caminho onde ficarao as VM's
path=/home/vm/images/lab

# Se o parametro não é vazio
if [ ! -z $1 ]
then
	# Desliga VM Matriz caso esteja running (obrigatório)
	state=$(virsh domstate matriz-win7)
	if [ $state == "running" ] 
	then 
		virsh destroy matriz-win7
	fi
	for (( maq=0; maq<=$1; maq++ ))
	do
		# Trata o zero à esquerda do nome
		if test $maq -lt 10
		then
			nomedaVM=vm-w7-0$maq
		else
			nomedaVM=vm-w7-$maq
		fi
		
		# Comando para clonar
		virt-clone --original matriz-win7 --name $nomedaVM --file $path/$nomedaVM.img
		# feedback ao user com gauge
		clear
		echo Clonando maquina ${nomedaVM} [ $maq de $1 ]
		echo Aguarde...
	done
else
	echo "Sintaxe correta é: sh "$0" <qtde-vm-a-serem-criadas>"
fi
