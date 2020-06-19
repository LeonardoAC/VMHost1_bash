#!/bin/bash
# ---------------------------------------------------------------------------------
# Substitui a porta dinâmica por uma porta fixa (59xx);
# Seta um MAC Address de acordo com MAC's previamente habilitados no PFSense;
#
# Obs: cada vez que se clona uma VM, recebe um MAC randomico. Precisa setar o MAC
# de acordo com os que estão salvos no firewall. Se não, a rede da vm dará erro.
#
# By Leonardo A. Carrilho
# Fevereiro 2020
# ---------------------------------------------------------------------------------
# SINTAXE: sh setaporta-cloudera.sh <qtde>

# Obs: O Guest deve estar em estado "shut down".
# Caminho do XML das VM's
path=/etc/libvirt/qemu

# Array que contem MAC's a serem utilizados
# Estes MAC's estão salvos no firewall com o seu respectivo IP fixo
MAC[0]="52:54:00:bc:dc:00"
MAC[1]="52:54:00:bc:dc:01"
MAC[2]="52:54:00:bc:dc:02"
MAC[3]="52:54:00:bc:dc:03"
MAC[4]="52:54:00:bc:dc:04"
MAC[5]="52:54:00:bc:dc:05"
MAC[6]="52:54:00:bc:dc:06"
MAC[7]="52:54:00:bc:dc:07"
MAC[8]="52:54:00:bc:dc:08"
MAC[9]="52:54:00:bc:dc:09"


# Percorre os arquivos XML's (cloudera nn)

# Se a variavel não (!) está vazia (-z) entao:
if [ ! -z $1 ]
then
	for ((j=0; j<=$1; j++)) 
	do
		# Completa com zero à esqueda, no nome
		if test $j -lt 10
		then
			nome=cloudera0$j
		else
			nome=cloudera$j
		fi
		
		# Pára a VM caso esteja rodando
		state=$(virsh domstate $nome)
		if [[ $state == "running" ]]
		then
			virsh destroy $nome
		fi
	
		# Faz as substituicoes de portas:
		porta=$((j+40))
		sed -i "s/port='-1' autoport='yes'/port='59$porta' autoport='no'/g" $path/$nome.xml
	
		# Substitui o MAC default pelos salvos no PFSense
		sed -i "/<mac address='/c\<mac address='"${MAC[$j]}"'/>" $path/$nome.xml
	done
else
	echo " Sintaxe correta é: sh setaporta-cloudera.sh <qtde-vm>"
fi
