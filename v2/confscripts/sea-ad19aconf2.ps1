Write-Output `n "======================================================================================" 
Write-Output    "===============================  Set IPv4  to Static  ================================" 
Write-Output    "======================================================================================" `n

$IP = "11.0.1.11"
$MaskBits = 24 # This means subnet mask = 255.255.255.0
$Gateway = "11.0.1.1"
$Dns = @('10.0.1.11','8.8.8.8')
$IPType = "IPv4"

# Retrieve the network adapter that you want to configure
$adapter = Get-NetAdapter | ? {$_.Status -eq "up"}

# Remove any existing IPgateway from our ipv4 adapter
If (($adapter | Get-NetIPConfiguration).IPv4Address.IPAddress) {
 $adapter | Remove-NetIPAddress -AddressFamily $IPType -Confirm:$false
}

If (($adapter | Get-NetIPConfiguration).Ipv4DefaultGateway) {
 $adapter | Remove-NetRoute -AddressFamily $IPType -Confirm:$false
}

# Configure the IP address and default gateway
$adapter | New-NetIPAddress `
 -AddressFamily $IPType `
 -IPAddress $IP `
 -PrefixLength $MaskBits `
 -DefaultGateway $Gateway

# Configure the DNS client server IP addresses
$adapter | Set-DnsClientServerAddress -ServerAddresses $DNS

Write-Output `n "======================================================================================" 
Write-Output    "=========================  COMPLETE | COMPLETE | COMPLETE  ===========================" 
Write-Output    "======================================================================================" `n