Write-Output `n "======================================================================================" 
Write-Output    "=============================== Enable Ping Echo IPv4 ================================" 
Write-Output    "======================================================================================" `n

netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol="icmpv4:8,any" dir=in action=allow

Write-Output `n "======================================================================================" 
Write-Output    "===============================  Disable  IPv6 VMAD01 ================================" 
Write-Output    "======================================================================================" `n

# Disable IPv6 on Ethernet Adapter
Get-NetAdapterBinding -ComponentID ms_tcpip6
Disable-NetAdapterBinding -Name "Ethernet" -ComponentID ms_tcpip6

Write-Output `n "======================================================================================" 
Write-Output    "===============================  Wait for 30 seconds  ================================" 
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

Sleep-Progress 30

Write-Output `n "======================================================================================" 
Write-Output    "==============================  Create DB&LOG NTDS AD  ===============================" 
Write-Output    "======================================================================================" `n

New-Item -ItemType Directory -Force -Path C:\AD\DBNTDS\
New-Item -ItemType Directory -Force -Path C:\AD\LOGNTDS\
New-Item -ItemType Directory -Force -Path C:\AD\SYSVOL\

Write-Output `n "======================================================================================" 
Write-Output    "==============================  Install Google Chrome  ===============================" 
Write-Output    "======================================================================================" `n

$LocalTempDir = $env:TEMP; $ChromeInstaller = "ChromeInstaller.exe"; (new-object    System.Net.WebClient).DownloadFile('http://dl.google.com/chrome/install/375.126/chrome_installer.exe', "$LocalTempDir\$ChromeInstaller"); & "$LocalTempDir\$ChromeInstaller" /silent /install; $Process2Monitor =  "ChromeInstaller"; Do { $ProcessesFound = Get-Process | ?{$Process2Monitor -contains $_.Name} | Select-Object -ExpandProperty Name; If ($ProcessesFound) { "Still running: $($ProcessesFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 } else { rm "$LocalTempDir\$ChromeInstaller" -ErrorAction SilentlyContinue -Verbose } } Until (!$ProcessesFound)

Write-Output `n "======================================================================================" 
Write-Output    "================================  Configure AD & DNS  ================================" 
Write-Output    "======================================================================================" `n

mkdir 'C:\TEMP Downloads'
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/confxmls/addns.xml" -OutFile 'C:\TEMP Downloads\addns.xml'
Install-WindowsFeature -ConfigurationFilePath 'C:\TEMP Downloads\addns.xml'

Write-Output `n "======================================================================================" 
Write-Output    "==================================  Promote VMAD01  ==================================" 
Write-Output    "======================================================================================" `n
 
Write-Output    "=================================== Skip this first =================================="

Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module ADDSDeployment
Import-Module ADDSDeployment