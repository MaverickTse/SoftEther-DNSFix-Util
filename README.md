# SoftEther-DNSFix-Util
Scripts for automating and fixing DNS leak when using SoftEther VPN. See Release page for more details.

## Simpler solution
A simpler method would be setting the DNS of your default network interfaces (your LAN cards) to use Google's 8.8.8.8 and 8.8.4.4. This always work unless you are using some services that reject Google DNS or when you cannot even access anything Google.

## Simplest solution
Use OpenVPN client and add `block-outside-dns` into the ovpn profile file
