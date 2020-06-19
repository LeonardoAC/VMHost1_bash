#!/bin/sh

#------------------------------------------------------------
# Este script gera um Json contendo SOMENTE as Vm's w7 ativas
# Deve ser chamado pelo arquivo "retun-vm-w7-active.PHP"
# By Leonardo A. Carrilho
# Dezembro de 2018
#------------------------------------------------------------

# Seta Var
jsonfile="/usr/share/nginx/html/return-vm-w7-active.json"

# deleta o json, caso exista
if [ -e $jsonfile ]
then
	rm -f $jsonfile
fi

# Lista TODAS as Vm's com status "running" e grava em variavel
saidavirsh=$(virsh list | grep -i 'vm-w7' | grep 'running')

# Abre o json
JSON={\"nome\":[

# Contador de VM ativa
totalrow=0

# Monta o json
while IFS= read -r row
do
	# Retorna  o numero final
	JSON=$JSON\"${row:13:2}\",
	# Incrementa o contador
	totalrow=$((totalrow+1))
done <<< "$saidavirsh"

# Fecha o json
JSON=$JSON],\"total\":$totalrow}

# Cria arquivo Json
#touch $jsonfile

# Popula o arquivo
echo $JSON > $jsonfile

#remove a ultima virgula antes do fechamento do array (gambiarra)
sed -i 's/,]/]/g' $jsonfile

