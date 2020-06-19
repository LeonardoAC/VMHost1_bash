#!/bin/sh
#
# --------------------------------------------------------
# "Amarra" o Mac Address do raspberry ao IP da VM
# Armazena esta ligacao caso o client tente se conectar
# novamente 
#
# Leonardo A. Carrilho
# leo_carrilho@hotmail.com
# 04 de setembro de 2019
# --------------------------------------------------------
#
# Recebe params de remotevm.sh
ClientMAC=$1
VMEmUso=$2

# Retorna o IP da VM
# OBS: O IP esta reservado no firewall principal
# As VM's nao tem IP setado nelas. Usam DHCP
# Conforme o ID da VM sera atribuido o IP gravado no PFSense.

#case $VMEmUso in
#	"vm-w7-00") virsh start "vm-w7-00"; echo 172.16.0.130;;
#	"vm-w7-01") virsh start "vm-w7-01"; echo 172.16.0.131;;
#	"vm-w7-02") virsh start "vm-w7-02"; echo 172.16.0.132;;
#	"vm-w7-03") virsh start "vm-w7-03"; echo 172.16.0.133;;
#	"vm-w7-04") virsh start "vm-w7-04"; echo 172.16.0.134;;
#	"vm-w7-05") virsh start "vm-w7-05"; echo 172.16.0.135;;
#	"vm-w7-06") virsh start "vm-w7-06"; echo 172.16.0.136;;
#	"vm-w7-07") virsh start "vm-w7-07"; echo 172.16.0.137;;
#	"vm-w7-08") virsh start "vm-w7-08"; echo 172.16.0.138;;
#	"vm-w7-09") virsh start "vm-w7-09"; echo 172.16.0.139;;
#	"vm-w7-10") virsh start "vm-w7-10"; echo 172.16.0.140;;
#	*) echo 169.0.0.1;;
#esac

#----------------------------------------------
# DEBUG	
# --------------------------------------------
# Descomente as linhas abaixo para acompanhar o retorno 
# Comente novamente para entrar em producao
# Isso nao vai disparar uma VM
#
#echo "bind mac -> $ClientMAC"
#echo "bind vm -> $VMEmUso"
#
case $VMEmUso in
	"vm-w7-00") echo 172.16.0.130;;
	"vm-w7-01") echo 172.16.0.131;;
	"vm-w7-02") echo 172.16.0.132;;
	"vm-w7-03") echo 172.16.0.133;;
	"vm-w7-04") echo 172.16.0.134;;
	"vm-w7-05") echo 172.16.0.135;;
	"vm-w7-06") echo 172.16.0.136;;
	"vm-w7-07") echo 172.16.0.137;;
	"vm-w7-08") echo 172.16.0.138;;
	"vm-w7-09") echo 172.16.0.139;;
	"vm-w7-10") echo 172.16.0.140;;
	*) echo 169.0.0.1;;
esac

