#!/bin/sh

# Leonardo A. Carrilho
# leo_carrilho@hotmail.com
# Fevereiro de 2020

# Retorna a qtde total (running e shut off) de VM's cloudera existentes

existingVMTotal=$(virsh list --all | grep -o "cloudera" | wc -l)
echo $existingVMTotal

exit
