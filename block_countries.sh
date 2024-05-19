#!/bin/bash

# Crie o conjunto 'countries' no ipset
sudo ipset create countries hash:net,port

# Defina os códigos dos países que deseja bloquear
COUNTRIES=('cn' 'ru' 'tw' 'kp')

# Primeiro loop: percorre cada código de país na lista COUNTRIES
for i in "${COUNTRIES[@]}"; do
    # Segundo loop: obtém a lista de IPs do país atual e percorre cada IP
    for IP in $(wget -O - http://www.ipdeny.com/ipblocks/data/countries/${i}.zone)
    do
        # Adiciona o IP ao conjunto 'countries' no ipset, bloqueando a porta 22
        sudo ipset add countries $IP,22
    done
done

# Integre o ipset com o iptables para bloquear o tráfego
sudo iptables -I INPUT -m set --match-set countries src -j DROP
sudo iptables -I FORWARD -m set --match-set countries src -j DROP
