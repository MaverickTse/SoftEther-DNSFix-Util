# Restore DNS after SE-VPN session
#netsh interface IPv4 delete dnsservers "乙太網路" all
#ipconfig /flushdns
Clear-DnsClientCache
Set-DnsClientServerAddress -InterfaceAlias "乙太網路" -ResetServerAddresses
