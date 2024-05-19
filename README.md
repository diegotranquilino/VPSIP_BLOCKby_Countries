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
