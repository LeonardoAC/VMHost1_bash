#!/bin/bash
# -------------------------------
# Deleta TODAS as vm-w7
# Pára a VM (destroy);
# Deleta a VM (undefine);
# By Leonardo A. Carrilho
# Dezembro de 2018
# ------------------------------
# SINTAXE: sh deleta-vm-w7.sh <qtde>

# Caminho onde estão as VM's
path=/home/vm/images/lab

# confere se recebeu parametro (qtde de vm's)
if [ ! -z $1 ]
then
	for (( maq=0; maq<=$1; maq++ ))
	do
		#echo $maq
		### Prepara o nome das máq.
		if test $maq -lt 10
	        then
	            	nomedaVM=vm-w7-0$maq
			#nomedaVM=f01e0$maq
	        else
	            	nomedaVM=vm-w7-$maq
			#nomedaVM=f01e$maq
	        fi
		# Pára a VM
		virsh destroy $nomedaVM
		# Deleta a VM - XML
		virsh undefine $nomedaVM 
		# deleta a imagem da pasta
		rm -f $path/$nomedaVM.img
	done
	clear
	echo "LISTA TODAS AS VM's"
	echo ""
	virsh list --all
	echo "---------------------------"
	echo "RESUMO DO DIRETÓRIO LAB:"
	echo ""
	ls $path
else
	echo "Sintaxe correta é: sh deteta-vm-w7.sh <qtde-vm>"
fi
