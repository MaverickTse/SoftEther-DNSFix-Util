Start-Process -FilePath "C:\Program Files\SoftEther VPN Client\vpncmgr_x64.exe" -ArgumentList "AA447B28A1CD5932DA0BFC3DA12E1294A7392D86" -WorkingDirectory "C:\Program Files\SoftEther VPN Client"
Start-Sleep -Seconds 10
Set-DnsClientServerAddress -InterfaceAlias "乙太網路" -ServerAddresses ("10.211.254.254")
Clear-DnsClientCache