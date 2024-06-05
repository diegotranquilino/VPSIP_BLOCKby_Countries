# VPS-BLOCK-Countries
This directory is to prevent direct attacks from determined Countries

To protect your Linux VPS from attacks originating from a specific country, you can use the ipset tool in conjunction with iptables. Here is a step-by-step guide on how to do this:

Install ipset:
On Debian: 
```
apt update && apt install ipset
```
On Ubuntu:
```
sudo apt update && sudo apt install ipset'
```
On CentOS: 
```
sudo yum install ipset
```
Create a set in ipset to contain the countries whose IP addresses you want to block:
ipset create countries hash:net,port

Save the script to a file, for example block_countries.sh

Give the file execution permission with the command
```
chmod +x block_countries.sh
```
Run the script with 
```
sudo ./block_countries.sh
```

<h2>Unblock countries that have been blocked</h2>

To allow access to a country that was previously blocked on your Linux VPS, you can follow these steps:

Identify the ipset set that contains the IP addresses of the country you want to unblock. If you followed the previous guide, the set should be called countries.
Remove the country IP addresses from the ipset set. For example, to remove China IPs, you would use the following command:
for ip in $(wget -O - http://www.ipdeny.com/ipblocks/data/countries/cn.zone)
of
 sudo ipset del countries $ip
done

Repeat the process for each country you want to unlock, replacing 'cn' with the corresponding country code.
Save changes to ipset so they persist after reboot:
sudo ipset save > /etc/ipset.conf

Make sure iptables is configured correctly to no longer block traffic from these IPs.
Remember that by removing a country's IPs from the ipset set, you are allowing all traffic from that country to access your server again. So make sure this is in line with your security policy and consider maintaining other security measures to protect your VPS.


<h2>Blacklist management</h2>

Create a set in ipset:
sudo ipset create blacklist hash:ip

Add IP to blacklist:
sudo ipset add blacklist 143.198.76.118

Create a rule in iptables to block all blacklisted IPs:
sudo iptables -I INPUT -m set --match-set blacklist src -j DROP

Remember to save your iptables and ipset settings so they persist across system restarts. For iptables you can use iptables-save and for ipset you can use ipset save
