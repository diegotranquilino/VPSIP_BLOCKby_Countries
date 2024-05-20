# VPS-BLOCK-Countries
This directory is to prevent direct attacks from determined Countries

Para proteger seu VPS Linux de ataques originados de um país específico, você pode utilizar a ferramenta ipset em conjunto com o iptables. Aqui está um guia passo a passo sobre como fazer isso:

Instale o ipset:
No Debian: apt update && apt install ipset
No Ubuntu: sudo apt update && sudo apt install ipset
No CentOS: sudo yum install ipset
Crie um conjunto no ipset para conter os países cujos endereços IP você deseja bloquear:
ipset create countries hash:net,port

Salve o script em um arquivo, por exemplo, block_countries.sh

Dê permissão de execução ao arquivo com o comando chmod +x block_countries.sh

Execute o script com sudo ./block_countries.sh

<h2>Liberar países que foram bloqueados</h2>

Para liberar o acesso de um país que foi previamente bloqueado no seu VPS Linux, você pode seguir estes passos:

Identifique o conjunto do ipset que contém os endereços IP do país que você deseja desbloquear. Se você seguiu o guia anterior, o conjunto deve ser chamado countries.
Remova os endereços IP do país do conjunto do ipset. Por exemplo, para remover os IPs da China, você usaria o seguinte comando:
for ip in $(wget -O - http://www.ipdeny.com/ipblocks/data/countries/cn.zone)
do
  sudo ipset del countries $ip
done

Repita o processo para cada país que você deseja desbloquear, substituindo ‘cn’ pelo código do país correspondente.
Salve as alterações no ipset para que elas persistam após a reinicialização:
sudo ipset save > /etc/ipset.conf

Verifique se o iptables está configurado corretamente para não bloquear mais o tráfego desses IPs.
Lembre-se de que, ao remover os IPs de um país do conjunto do ipset, você está permitindo que todo o tráfego daquele país acesse seu servidor novamente. Portanto, certifique-se de que isso está alinhado com sua política de segurança e considere manter outras medidas de segurança para proteger seu VPS.




<h2>Blacklist management</h2>

Crie um conjunto no ipset:
sudo ipset create blacklist hash:ip

Adicione o IP à lista negra:
sudo ipset add blacklist 143.198.76.118

Crie uma regra no iptables para bloquear todos os IPs na lista negra:
sudo iptables -I INPUT -m set --match-set blacklist src -j DROP

Lembre-se de salvar as configurações do iptables e do ipset para que elas persistam após reinicializações do sistema. Para o iptables, você pode usar o iptables-save e para o ipset, você pode usar o ipset save
