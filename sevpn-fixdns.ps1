# Fix DNS leak for SoftEther-VPN
# Run this once after connected to VPN
#netsh interface IPv4 set dnsserver "乙太網路" static 10.211.254.254
#ipconfig /flushdns
Clear-DnsClientCache
Set-DnsClientServerAddress -InterfaceAlias "乙太網路" -ServerAddresses ("10.211.254.254")
