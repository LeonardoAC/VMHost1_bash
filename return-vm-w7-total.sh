#!/bin/sh

# Leonardo A. Carrilho
# leo_carrilho@hotmail.com
# 30/ago/2019

# Retorna a qtde total (running e shut off) de VM's vm-w7 existentes

existingVMTotal=$(virsh list --all | grep -o "vm-w7" | wc -l)
echo $existingVMTotal

exit
