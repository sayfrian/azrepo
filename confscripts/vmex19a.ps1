Write-Output `n "======================================================================================" 
Write-Output    "=============================== Enable Ping Echo IPv4 ================================" 
Write-Output    "======================================================================================" `n

netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol="icmpv4:8,any" dir=in action=allow

Write-Output `n "======================================================================================" 
Write-Output    "===============================  Set IPv4  to Static  ================================" 
Write-Output    "======================================================================================" `n

$IP = "10.0.0.11"
$MaskBits = 24 # This means subnet mask = 255.255.255.0
$Gateway = "10.0.0.1"
$Dns = @('10.0.0.11','8.8.8.8')
$IPType = "IPv4"

# Retrieve the network adapter that you want to configure
$adapter = Get-NetAdapter | ? {$_.Status -eq "up"}

# Remove any existing IP, gateway from our ipv4 adapter
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
Write-Output    "===============================  Disable  IPv6 VMAD01 ================================" 
Write-Output    "======================================================================================" `n

# Disable IPv6 on Ethernet Adapter
Get-NetAdapterBinding -ComponentID ms_tcpip6
Disable-NetAdapterBinding -Name "Ethernet" -ComponentID ms_tcpip6

Write-Output `n "======================================================================================" 
Write-Output    "============================  Change Drive Letter Disk  ==============================" 
Write-Output    "======================================================================================" `n

$DVD_Drive = Get-WmiObject win32_volume -filter 'DriveType=5'
$DVD_Drive.DriveLetter = "A:"
$DVD_Drive.Put()

Write-Output `n "======================================================================================" 
Write-Output    "===============================  Initialize RAW Disk  ================================" 
Write-Output    "======================================================================================" `n

Get-Disk |
Where partitionstyle -eq ‘raw’ |
Initialize-Disk -PartitionStyle GPT -PassThru |
New-Partition -AssignDriveLetter -UseMaximumSize |
Format-Volume -FileSystem NTFS -NewFileSystemLabel “Data Disk” -Confirm:$false

Write-Output `n "======================================================================================" 
Write-Output    "==============================  Create DB&LOG NTDS AD  ===============================" 
Write-Output    "======================================================================================" `n

New-Item -ItemType Directory -Force -Path C:\Windows\DBNTDS\
New-Item -ItemType Directory -Force -Path C:\Windows\LOGNTDS\

Write-Output `n "======================================================================================" 
Write-Output    "==============================  Install Google Chrome  ===============================" 
Write-Output    "======================================================================================" `n

$LocalTempDir = $env:TEMP; $ChromeInstaller = "ChromeInstaller.exe"; (new-object    System.Net.WebClient).DownloadFile('http://dl.google.com/chrome/install/375.126/chrome_installer.exe', "$LocalTempDir\$ChromeInstaller"); & "$LocalTempDir\$ChromeInstaller" /silent /install; $Process2Monitor =  "ChromeInstaller"; Do { $ProcessesFound = Get-Process | ?{$Process2Monitor -contains $_.Name} | Select-Object -ExpandProperty Name; If ($ProcessesFound) { "Still running: $($ProcessesFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 } else { rm "$LocalTempDir\$ChromeInstaller" -ErrorAction SilentlyContinue -Verbose } } Until (!$ProcessesFound)

Write-Output `n "======================================================================================" 
Write-Output    "================================  Configure AD & DNS  ================================" 
Write-Output    "======================================================================================" `n

# Download the script from GitHub
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/sayfuladrian/azure/feature/elbrm/confad01-addns.xml" -OutFile .\Downloads\confad01-addns.xml

# Install AD and DNS with the downloaded script.
Install-WindowsFeature -ConfigurationFilePath .\Downloads\confad01-addns.xml

Write-Output `n "======================================================================================" 
Write-Output    "==================================  Promote VMAD01  ==================================" 
Write-Output    "======================================================================================" `n

Import-Module ADDSDeployment
$passAd = ConvertTo-SecureString "Jakarta@2022" -AsPlainText -Force
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "E:\Windows\DBNTDS" `
-DomainMode "WinThreshold" `
-DomainName "pavilico.my.id" `
-DomainNetbiosName "AD" `
-ForestMode "WinThreshold" `
-InstallDns:$true `
-LogPath "E:\Windows\LOGNTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true `
-SafeModeAdministratorPassword $passAd

Write-Output `n "======================================================================================" 
Write-Output    "==========================  Change DNS from loop to itself  ==========================" 
Write-Output    "======================================================================================" `n

$Dns = @('10.0.2.13','8.8.8.8')
$adapter = Get-NetAdapter -Name "ethernet"
$adapter | Set-DnsClientServerAddress -ServerAddresses $Dns

Write-Output `n "======================================================================================" 
Write-Output    "===========================  Add Reverse Lookup Zone on DNS  ===========================" 
Write-Output    "======================================================================================" `n

