#!/bin/sh -x
# ------------------------------------------------------------------------------
# Leonardo A. Carrilho
# 10-jan-2020
# Script para IMPORTACAO de QCOW2 sem necessidade de criar uma VM do zero e passar pelo processo de instalação.
#
# Obs: Apos comando disk eh utilizado o --import (importar um qcow2 existente)
# 
# +++++++++++++++++++++++++++++++++ PARAMS ++++++++++++++++++++++++++++++++++++++
# 
# $1 nome que sera dado à imagem importada
# $2 qtde memoria RAM - 4 caracteres
# $3 porta a ser usada
# $4 diretorio (lab; ti; iso; ...) onde está a qcow2
# $5 nome da qcow2 (sem usar a extensão)
# 
# Obs2: qtde de processadores, tamanho HD e o tipo do OS serão setados manualmente 
# neste arquivo, pois não sao tao corriqueiros.
# 
# Obs3: Precisamos ter um qcow2 para cada vm importada. Entao copiaremos a matriz pela qtde de vezes que se deseja 
# importar vm's
# 
# linha 23

function exibeCredito(){
	# Exibe uma mensagem na tela
	clear
	echo "----------------------------------"
	echo " I M P O R T A N D O    Q C O W 2 "
	echo " "
	echo " Version:fev 2020 - Leonardo A. C."
	echo "----------------------------------"
	echo " "
}

# Rotina de importação da VM
function importa(){
	# NAO ALTERE NADA AQUI!
	#
	# Obs: a numeracao das portas será sequencial
	#
	PORTA=$4
	for (( i=0; i <= $QTDEVM; i++ )) do
		echo "importando..."$PORTA
		virt-install \
		--connect qemu:///system \
		--name $1$i \
		--ram $2 \
		--vcpus=$3 \
		--disk path=$5/$6$i.qcow2,size=$tamanhoHD,bus=ide --import \
		--graphics vnc,port=$PORTA,listen=0.0.0.0 \
		--noautoconsole \
		--os-type $tipoSO \
		--os-variant $template \
		--accelerate \
		--network=bridge:virbr0 \
		--hvm 
		# feddback
		echo "importou $1$i na porta $PORTA ..."
		# Incrementa porta
		PORTA=$(($PORTA+1))
	done
}

function replicaMatrizQCow2(){
	MATRIZ="matriz-cloudera.qcow2"
	for (( i=0; i<=$QTDEVM; i++ )) do
		echo "Iniciando replica # $i de $QTDEVM"
		if [ ! -e $1/$2-$i.qcow2 ] # So copia se não existir
		then
			# path [$1] nome [$2]
			# replica n vezes - o nome recebe o sufixo nn
			#echo "copiando [$1/$MATRIZ] em [$1/$2-$i.qcow2]"
			cp $1/$MATRIZ $1/$2$i.qcow2
		else
			echo "$1/$2$i.qcow2 já existe! [pulando]"
		fi
	done
}

# -----------------------
# Começa aqui:
# -----------------------
# Verifica se passaram os parametros:
if [ -z $1 ]; then
	echo "Informe um nome para a VM | SINTAXE: importa-qcow2.sh <nome-para-vm> <RAM> <porta> <dir> <nome-qcow2>"
elif [ -z $2 ]; then
	echo "Informe a qtde mem. RAM | SINTAXE: importa-qcow2.sh <nome-para-vm> <RAM> <porta> <dir> <nome-qcow2>"
elif [ -z $3 ]; then
	echo "Informe a porta desejada | SINTAXE: importa-qcow2.sh <nome-para-vm> <RAM> <porta> <dir> <nome-qcow2>"
elif [ -z $4 ]; then
	echo "Informe o DIR onde esta a qcow2 (lab, ti, iso...) | SINTAXE: importa-qcow2.sh <nome-para-vm> <RAM> <porta> <dir> <nome-qcow2>"
elif [ -z $5 ]; then
	echo "Informe o nome do arquivo qcow2 | SINTAXE: importa-qcow2.sh <nome-para-vm> <RAM> <porta> <dir> <nome-qcow2>"
else
	# recupera as variáveis abaixo
	VMNome=$1
	qtdeRam=$2
	qtdeProcessador=2
	PORT=$3
	CAMINHO=/home/vm/images/$4
	imgParaSerImportada=$5
	tamanhoHD=20
	tipoSO=centos
	template=centos7.0
		
	# Constante - qtde Vms a serem criadas
	QTDEVM=9
	
	exibeCredito

	# Faz as "n" copias da matriz
	replicaMatrizQCow2 "/home/vm/images/$4" $5

	# Chama a rotina de importacao
	importa $VMNome $qtdeRam $qtdeProcessador $PORT $CAMINHO $imgParaSerImportada $tamanhoHD $tipoSO $template

	# debug
	#echo $VMNome $qtdeRam $qtdeProcessador $PORT $importFromQcow2 $tamanhoHD $tipoSO $template
fi
