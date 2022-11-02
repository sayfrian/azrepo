Write-Output `n "======================================================================================" 
Write-Output    "=============================== Enable Ping Echo IPv4 ================================" 
Write-Output    "======================================================================================" `n

netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol="icmpv4:8,any" dir=in action=allow

Write-Output `n "======================================================================================" 
Write-Output    "===============================  Set IPv4  to Static  ================================" 
Write-Output    "======================================================================================" `n

$IP = "10.0.0.12"
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
Write-Output    "===============================  Disable  IPv6 VMEX01  ================================" 
Write-Output    "======================================================================================" `n

# Disable IPv6 on Ethernet Adapter
Get-NetAdapterBinding -ComponentID ms_tcpip6
Disable-NetAdapterBinding -Name "Ethernet" -ComponentID ms_tcpip6

Write-Output `n "======================================================================================" 
Write-Output    "===============================  Wait for 15 seconds  ================================" 
Write-Output    "======================================================================================" `n

Function Sleep-Progress($seconds) {
    $s = 0;
    Do {
        $p = [math]::Round(100 - (($seconds - $s) / $seconds * 100));
        Write-Progress -Activity "Waiting..." -Status "$p% Complete:" -SecondsRemaining ($seconds - $s) -PercentComplete $p;
        [System.Threading.Thread]::Sleep(1000)
        $s++;
    }
    While($s -lt $seconds);
    
}

Sleep-Progress 15

Write-Output `n "======================================================================================" 
Write-Output    "==============================  Install Google Chrome  ===============================" 
Write-Output    "======================================================================================" `n

$LocalTempDir = $env:TEMP; $ChromeInstaller = "ChromeInstaller.exe"; (new-object    System.Net.WebClient).DownloadFile('http://dl.google.com/chrome/install/375.126/chrome_installer.exe', "$LocalTempDir\$ChromeInstaller"); & "$LocalTempDir\$ChromeInstaller" /silent /install; $Process2Monitor =  "ChromeInstaller"; Do { $ProcessesFound = Get-Process | ?{$Process2Monitor -contains $_.Name} | Select-Object -ExpandProperty Name; If ($ProcessesFound) { "Still running: $($ProcessesFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 } else { rm "$LocalTempDir\$ChromeInstaller" -ErrorAction SilentlyContinue -Verbose } } Until (!$ProcessesFound)

Write-Output `n "======================================================================================" 
Write-Output    "===================================  Join Domain  ====================================" 
Write-Output    "======================================================================================" `n

$dc = "minilico.xyz" # Specify the domain to join.
$pw = "Jakarta@2022" | ConvertTo-SecureString -asPlainText –Force # Specify the password for the domain admin.
$usr = "$dc\rian" # Specify the domain admin account.
$creds = New-Object System.Management.Automation.PSCredential($usr,$pw)
Add-Computer -DomainName $dc -Credential $creds -restart -force -verbose 
# Note that the computer will be restarted automatically.

Write-Output `n "======================================================================================" 
Write-Output    "===========================  Download Exchange 2019 Cu12   ===========================" 
Write-Output    "======================================================================================" `n

mkdir "C:\TEMP Downloads" -Force
$URL = 'https://download.microsoft.com/download/b/c/7/bc766694-8398-4258-8e1e-ce4ddb9b3f7d/ExchangeServer2019-x64-CU12.ISO'
$Path= "C:\TEMP Downloads\EX19-x64-CU12.iso"
(New-Object System.Net.WebClient).DownloadFile($URL, $Path)

Write-Output `n "======================================================================================" 
Write-Output    "=============================  Mount Exchange 2019 Cu12  =============================" 
Write-Output    "======================================================================================" `n

Mount-DiskImage -ImagePath 'C:\TEMP Downloads\EX19-X64-CU12.ISO'

Write-Output `n "======================================================================================" 
Write-Output    "==============================  Exchange  Installation  ==============================" 
Write-Output    "======================================================================================" `n

Write-Output `n "=========================  Download Net 4.8 Installation  ============================" `n

$URL = "https://download.visualstudio.microsoft.com/download/pr/2d6bb6b2-226a-4baa-bdec-798822606ff1/8494001c276a4b96804cde7829c04d7f/ndp48-x86-x64-allos-enu.exe"
$Path= "C:\TEMP Downloads\netfw_4-8.exe"
(New-Object System.Net.WebClient).DownloadFile($URL, $Path)

Write-Output `n "=============================  Download VCRedist 2012  ===============================" `n

$URL = "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe"
$Path= "C:\TEMP Downloads\vcredist2012_x64.exe"
(New-Object System.Net.WebClient).DownloadFile($URL, $Path)

Write-Output `n "=============================  Download VCRedist 2013  ===============================" `n

$URL = "https://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x64.exe"
$Path= "C:\TEMP Downloads\vcredist2013_x64.exe"
(New-Object System.Net.WebClient).DownloadFile($URL, $Path)

Write-Output `n "==================  Download Unified Communication Installation  =====================" `n

$URL = "https://download.microsoft.com/download/2/C/4/2C47A5C1-A1F3-4843-B9FE-84C0032C61EC/UcmaRuntimeSetup.exe"
$Path= "C:\TEMP Downloads\UcmaSetup.exe"
(New-Object System.Net.WebClient).DownloadFile($URL, $Path)

Write-Output `n "===================  Download Unified Communication Installation  ====================" `n

$URL = "https://webpihandler.azurewebsites.net/web/handlers/webpi.ashx/getinstaller/urlrewrite2.appids"
$Path= "C:\TEMP Downloads\urlrewrite.exe"
(New-Object System.Net.WebClient).DownloadFile($URL, $Path)

Write-Output `n "==========================  Pre-requisite:  Installation  ============================" `n

Start-Process -FilePath "C:\TEMP Downloads\vcredist2012_x64.exe" /silent -verbose
Start-Process -FilePath "C:\TEMP Downloads\vcredist2013_x64.exe" /silent -verbose

Start-Process -FilePath "C:\TEMP Downloads\netfw_4-8.exe" /silent -verbose
$confirmation = Read-Host "Udah selesai installnya? [pencet enter kalo udah]"

Start-Process -FilePath "C:\TEMP Downloads\UcmaSetup.exe" /silent -verbose
$confirmation = Read-Host "Udah selesai installnya? [pencet enter kalo udah]"

Start-Process -FilePath "C:\TEMP Downloads\rewrite21.msi" /silent -verbose
$confirmation = Read-Host "Udah selesai installnya? [pencet enter kalo udah]"

Write-Output `n "=========================  Exchange Inst.  Prepare Schema  =========================" `n

cd E:\
.\Setup.exe /IAcceptExchangeServerLicenseTerms_DiagnosticDataOFF /PrepareSchema

Write-Output `n "===========================  Exchange Inst. Prepare AD  ============================" `n

.\Setup.exe /IAcceptExchangeServerLicenseTerms_DiagnosticDataOFF /PrepareAD /OrganizationName: "MINILICO"

Write-Output `n "========================  Exchange Inst. Prepare Domains  ==========================" `n

.\Setup.exe /IAcceptExchangeServerLicenseTerms_DiagnosticDataOFF /PrepareAllDomains

Write-Output `n "=============================  Exchange Version List  ==============================" `n

# Exchange Schema Version
$sc = (Get-ADRootDSE).SchemaNamingContext
$ob = "CN=ms-Exch-Schema-Version-Pt," + $sc
Write-Output "RangeUpper: $((Get-ADObject $ob -pr rangeUpper).rangeUpper)"
 
# Exchange Object Version (domain)
$dc = (Get-ADRootDSE).DefaultNamingContext
$ob = "CN=Microsoft Exchange System Objects," + $dc
Write-Output "ObjectVersion (Default): $((Get-ADObject $ob -pr objectVersion).objectVersion)"
 
# Exchange Object Version (forest)
$cc = (Get-ADRootDSE).ConfigurationNamingContext
$fl = "(objectClass=msExchOrganizationContainer)"
Write-Output "ObjectVersion (Configuration): $((Get-ADObject -LDAPFilter $fl -SearchBase $cc -pr objectVersion).objectVersion)"

Write-Output `n "===============================  Run Installation  ================================" `n

cd 'C:\TEMP Downloads\Exchange\'
.\Setup.exe 

Write-Output `n "=================================  Add License  ===================================" `n

Set-ExchangeServer "EX01-2016" -ProductKey XXXXX-XXXXX-XXXXX-XXXXX

Write-Output `n "===============================  Restart Service  =================================" `n

net stop "Microsoft Exchange Information Store"
net start "Microsoft Exchange Information Store"

Write-Output `n "===============================  EXCHANGE  MODULE  =================================" `n
Write-Output `n "=================================  Check License  ==================================" `n


Get-ExchangeServer | ft Name,Edition,ProductID,IsExchangeTrialEdition -Auto

Get-MailboxDatabase
Set-MailboxDatabase "Mailbox Database 0082421626" -Name "DB01"
New-SendConnector -Name "Internet email PS" -Usage "Internet" -SourceTransportServers "VMEX19A" -DNSRoutingEnabled $True -AddressSpaces ("SMTP:*;5") -IsScopedConnector $False -UseExternalDNSServersEnabled $false
Get-SendConnector | Format-Table Identity, AddressSpaces, SourceTransportServers, MaxMessageSize, Enabled

Write-Output `n "===============================  EXCHANGE  MODULE  =================================" `n
Write-Output `n "==========================  Configure Internal External  ===========================" `n

Get-ClientAccessServer -Identity VMEX19A | Set-ClientAccessServer –AutoDiscoverServiceInternalUri https://autodiscover.minilico.xyz/Autodiscover/Autodiscover.xml
Get-ClientAccessService -Identity VMEX19A | Format-List Identity, AutoDiscoverServiceInternalUri

Get-EcpVirtualDirectory -Server VMEX19A | Set-EcpVirtualDirectory -ExternalUrl https://mail.minilico.xyz/ecp -InternalUrl https://mail.minilico.xyz/ecp
Get-EcpVirtualDirectory -Server VMEX19A | Format-List InternalUrl, ExternalUrl

Get-WebServicesVirtualDirectory -Server VMEX19A | Set-WebServicesVirtualDirectory -ExternalUrl https://mail.minilico.xyz/EWS/Exchange.asmx -InternalUrl https://mail.minilico.xyz/EWS/Exchange.asmx
Get-WebServicesVirtualDirectory -Server VMEX19A | Format-List InternalUrl, ExternalUrl

Get-MapiVirtualDirectory -Server VMEX19A | Set-MapiVirtualDirectory -ExternalUrl https://mail.minilico.xyz/mapi -InternalUrl https://mail.minilico.xyz/mapi
Get-MapiVirtualDirectory -Server VMEX19A | Format-List InternalUrl, ExternalUrl

Get-ActiveSyncVirtualDirectory -Server VMEX19A | Set-ActiveSyncVirtualDirectory -ExternalUrl https://mail.minilico.xyz/Microsoft-Server-ActiveSync -InternalUrl https://mail.minilico.xyz/Microsoft-Server-ActiveSync
Get-ActiveSyncVirtualDirectory -Server VMEX19A | Format-List InternalUrl, ExternalUrl

Get-OabVirtualDirectory -Server VMEX19A | Set-OabVirtualDirectory -ExternalUrl https://mail.minilico.xyz/OAB -InternalUrl https://mail.minilico.xyz/OAB
Get-OabVirtualDirectory -Server VMEX19A | Format-List InternalUrl, ExternalUrl

Get-OwaVirtualDirectory -Server VMEX19A | Set-OwaVirtualDirectory -ExternalUrl https://mail.minilico.xyz/owa -InternalUrl https://mail.minilico.xyz/owa
Get-OwaVirtualDirectory -Server VMEX19A | Format-List InternalUrl, ExternalUrl

Get-PowerShellVirtualDirectory -Server VMEX19A | Set-PowerShellVirtualDirectory -ExternalUrl https://mail.minilico.xyz/powershell -InternalUrl https://mail.minilico.xyz/powershell
Get-PowerShellVirtualDirectory -Server VMEX19A | Format-List InternalUrl, ExternalUrl

Get-OutlookAnywhere -Server VMEX19A | Set-OutlookAnywhere -ExternalHostname mail.minilico.xyz -InternalHostname mail.minilico.xyz -ExternalClientsRequireSsl $true -InternalClientsRequireSsl $true -DefaultAuthenticationMethod NTLM
Get-OutlookAnywhere -Server VMEX19A | Format-List ExternalHostname, InternalHostname

Resolve-DnsName -Type MX minilico.xyz -Server 8.8.8.8 | Format-Table -AutoSize

Get-AntiPhishPolicy -Identity '*TN*' | Select-Object Name,WhenCreated,OrganizationalUnitRoot,Identity,DistinguishedName
Get-HostedContentFilterPolicy -Identity '*TN*' | Select-Object Name,WhenCreated,OrganizationalUnitRoot,Identity,DistinguishedName
Get-MalwareFilterPolicy -Identity '*TN*' | Select-Object Name,WhenCreated,OrganizationalUnitRoot,Identity,DistinguishedName