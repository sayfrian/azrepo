Write-Output `n "======================================================================================" 
Write-Output    "==============================  Set Replication to Any  ==============================" 
Write-Output    "======================================================================================" `n

Import-Module ADDSDeployment
Install-ADDSDomainController `
-NoGlobalCatalog:$false `
-CreateDnsDelegation:$false `
-CriticalReplicationOnly:$false `
-DatabasePath "C:\AD\DBNTDS" `
-DomainName "minilico.xyz" `
-InstallDns:$true `
-LogPath "C:\AD\LOGNTDS" `
-NoRebootOnCompletion:$false `
-SiteName "Default-First-Site-Name" `
-SysvolPath "C:\AD\SYSVOL" `
-Force:$true

Write-Output `n "==============================  Set Replication  to DC  ==============================" `n

#Install-ADDSDomainController `
-NoGlobalCatalog:$false `
-CreateDnsDelegation:$false `
-CriticalReplicationOnly:$false `
-DatabasePath "C:\AD\DBNTDS" `
-DomainName "minilico.xyz" `
-InstallDns:$true `
-LogPath "C:\AD\LOGNTDS" `
-NoRebootOnCompletion:$false `
-ReplicationSourceDC "eus-vmad19a.minilico.xyz" `
-SiteName "Default-First-Site-Name" `
-SysvolPath "C:\AD\SYSVOL" `
-Force:$true

Write-Output `n "======================================================================================" 
Write-Output    "=========================  COMPLETE | COMPLETE | COMPLETE  ===========================" 
Write-Output    "======================================================================================" `n