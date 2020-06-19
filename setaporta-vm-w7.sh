#!/bin/bash
# ---------------------------------------------------------------------------------
# Substitui a porta dinâmica por uma porta fixa (59xx);
# Seta um MAC Address de acordo com MAC's previamente habilitados no PFSense;
#
# Obs: cada vez que se clona uma VM, recebe um MAC randomico. Precisa setar o MAC
# de acordo com os que estão salvos no firewall. Se não, a rede da vm dará erro.
#
# By Leonardo A. Carrilho
# 04/12/2018
# ---------------------------------------------------------------------------------
# SINTAXE: sh setaporta-vm-w7.sh <qtde>

# Obs: O Guest deve estar em estado "shut down".
# Caminho do XML das VM's
path=/etc/libvirt/qemu

# Array que contem MAC's a serem utilizados
# Estes MAC's estão salvos no firewall com o seu respectivo IP fixo
MAC[0]="52:54:00:2f:03:84"
MAC[1]="52:54:00:d3:8a:cc"
MAC[2]="52:54:00:a6:15:17"
MAC[3]="52:54:00:d7:6d:85"
MAC[4]="52:54:00:ab:ce:72"
MAC[5]="52:54:00:f4:70:0e"
MAC[6]="52:54:00:6a:5b:11"
MAC[7]="52:54:00:61:e1:02"
MAC[8]="52:54:00:97:9c:9d"
MAC[9]="52:54:00:b3:01:61"
MAC[10]="52:54:00:55:e6:6e"
MAC[11]="52:54:00:f9:6c:1e"
MAC[12]="52:54:00:20:c9:db"
MAC[13]="52:54:00:a1:2d:5f"
MAC[14]="52:54:00:36:0f:91"
MAC[15]="52:54:00:10:54:5c"
MAC[16]="52:54:00:dd:2b:3c"
MAC[17]="52:54:00:58:9b:ca"
MAC[18]="52:54:00:b1:a0:47"
MAC[19]="52:54:00:d0:40:05"
MAC[20]="52:54:00:41:11:82"


# Percorre os arquivos XML's (vm-w7-nn)

# Se a variavel não (!) está vazia (-z) entao:
if [ ! -z $1 ]
then
	for ((j=0; j<=$1; j++)) 
	do
		# Completa com zero à esqueda, no nome
		if test $j -lt 10
		then
			nome=vm-w7-0$j
		else
			nome=vm-w7-$j
		fi
		
		# Pára a VM caso esteja rodando
		state=$(virsh domstate $nome)
		if [[ $state == "running" ]]
		then
			virsh destroy $nome
		fi
	
		# Faz as substituicoes de portas:
		porta=$((j+30))
		sed -i "s/port='-1' autoport='yes'/port='59$porta' autoport='no'/g" $path/$nome.xml
	
		# Substitui o MAC default pelos salvos no PFSense
		sed -i "/<mac address='/c\<mac address='"${MAC[$j]}"'/>" $path/$nome.xml
	done
else
	echo " Sintaxe correta é: sh setaporta-vm-w7.sh <qtde-vm>"
fi
