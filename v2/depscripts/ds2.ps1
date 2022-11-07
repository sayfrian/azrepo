$rg = "eus-rg"
$loc = "eastus"

$vnet = "vneteus-rg"
$nsgpbl = "nsgpbl"
$nsgpvt = "nsgpvt"

Write-Output `n "================================ ENVIRONMENT CREATION ================================"

Write-Output `n "======================================================================================" 
Write-Output    "================================  Creating RG: eus-rg   ================================" 
Write-Output    "======================================================================================" `n

$check = Get-AzResourceGroup -Name $rg -ErrorAction SilentlyContinue

if($check -eq $null){

    New-AzResourceGroup -Name $rg -Location $loc
	
}
else{

    Write-Host "RESOURCEGROUP: $rg already exist"
	
}

Write-Output `n "======================================================================================" 
Write-Output    "=================================   Creating  VNET   =================================" 
Write-Output    "======================================================================================" `n
$rg = "eus-rg"
$loc = "eastus"

$vnet = "vneteus-rg"
$nsgpbl = "nsgpbl"
$nsgpvt = "nsgpvt"

Write-Output `n "================================ ENVIRONMENT CREATION ================================"

Write-Output `n "======================================================================================" 
Write-Output    "================================  Creating RG: eus-rg   ================================" 
Write-Output    "======================================================================================" `n

$check = Get-AzResourceGroup -Name $rg -ErrorAction SilentlyContinue

if($check -eq $null){

    New-AzResourceGroup -Name $rg -Location $loc
	
}
else{

    Write-Host "RESOURCEGROUP: $rg already exist"
	
}

Write-Output `n "======================================================================================" 
Write-Output    "=================================   Creating  VNET   =================================" 
Write-Output    "======================================================================================" `n

$check = Get-AzVirtualNetwork -Name $vnet -ErrorAction SilentlyContinue

if($check -eq $null){
	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vn-2sub.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/vn-2sub.json"
}

else{

    Write-Host "VIRTUALNETWORK $vnet already exist"

}

Write-Output `n "======================================================================================" 
Write-Output    "==================================   Creating NSG   ==================================" 
Write-Output    "======================================================================================" `n

$check = Get-AzNetworkSecurityGroup -Name $nsgpbl -ErrorAction SilentlyContinue

if($check -eq $null){

New-AzResourceGroupDeployment `
  -Name remoteTemplateDeployment `
  -ResourceGroupName $rg `
  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/nsg.json" `
  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parametersnsgPbl.json"
  
}

else{

    Write-Host "NSG: $nsgpbl already exist"

}

Write-Output    "===================================  On progress  ====================================" 

$check = Get-AzNetworkSecurityGroup -Name $nsgpvt -ErrorAction SilentlyContinue

if($check -eq $null){

New-AzResourceGroupDeployment `
  -Name remoteTemplateDeployment `
  -ResourceGroupName $rg `
  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/nsg.json" `
  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parametersnsgPvt.json"
  
}

else{

    Write-Host "NSG: $nsgpvt already exist"

}

Write-Output `n "======================================================================================" 
Write-Output    "===============================  Creating PublicIPAdd ================================" 
Write-Output    "======================================================================================" `n

$check = Get-AzPublicIpAddress -Name 'pipws10a' -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/pipBsc.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameterspipBscWs10a.json"
	  
}

else{

    Write-Host "pipws10a already exist"

}

Write-Output    "===================================  On progress  ====================================" 

$check = Get-AzPublicIpAddress -Name 'pipad19a' -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/pipBsc.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameterspipBscAd19a.json"
	  
}

else{

    Write-Host "pipad19a already exist"

}

Write-Output    "===================================  On progress  ====================================" 

$check = Get-AzPublicIpAddress -Name 'pipex19a' -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/pipBsc.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameterspipBscEx19a.json"
	  
}

else{

    Write-Host "pipex19a already exist"

}

Write-Output    "===================================  On progress  ====================================" 

$check = Get-AzPublicIpAddress -Name 'piphv19a' -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/pipBsc.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameterspipBscHv19a.json"
	  
}

else{

    Write-Host "piphv19a already exist"

}

Write-Output    "===================================  On progress  ====================================" 

$check = Get-AzPublicIpAddress -Name 'pipfw01pbl' -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/pipStd.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameterspipStdFw01Pbl.json"
	  
}

else{

    Write-Host "pipfw01pbl already exist"

}

Write-Output    "===================================  On progress  ====================================" 

$check = Get-AzPublicIpAddress -Name 'pipfw01mgt' -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/pipStd.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameterspipStdFw01Mgt.json"
	  
}

else{

    Write-Host "pipfw01mgt already exist"

}

Write-Output `n "======================================================================================" 
Write-Output    "==============================  Creating VNetIntface  ================================" 
Write-Output    "======================================================================================" `n

$check = Get-AzNetworkInterface -Name 'eus-vnicws10a' -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vnic-ip4.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parametersvnicws10a.json"
	  
}

else{

    Write-Host "VNICWS10A already exist"

}

Write-Output    "===================================  On progress  ====================================" 

$check = Get-AzNetworkInterface -Name 'vnicad19a' -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vnic-ip4.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/vnicad19a.json"
	  
}

else{

    Write-Host "VNICAD19A already exist"

}

Write-Output    "===================================  On progress  ====================================" 

$check = Get-AzNetworkInterface -Name 'vnicex19a' -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vnic-ip4.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/vnicex19a.json"
	  
}

else{

    Write-Host "VNICEX19A already exist"

}

Write-Output    "===================================  On progress  ====================================" 

$check = Get-AzNetworkInterface -Name 'vnichv19a' -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vnic-ip4.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/vnichv19a.json"
	  
}

else{

    Write-Host "VNICHV19A already exist"

}

Write-Output `n "======================================================================================" 
Write-Output    "================================     Creating VM      ================================" 
Write-Output    "======================================================================================" `n

$check = Get-AzVM -Name 'vmws10a' -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vm-pip-nodisk.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/vmws10a.json"
	  
}

else{

    Write-Host "VMWS10A already exist"

}

Write-Output `n "======================================================================================" 
Write-Output    "================================   Configuration RDP  ================================" 
Write-Output    "======================================================================================" `n

$script = Invoke-WebRequest "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/confscripts/nsg-rdp.ps1"
Invoke-Expression $($script.Content)

Write-Output `n "======================================================================================" 
Write-Output    "==============================   COMMAND IS: FINISHED   ==============================" 
Write-Output    "======================================================================================" `n
$check = Get-AzVirtualNetwork -Name $vnet -ErrorAction SilentlyContinue

if($check -eq $null){
	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vn-2sub.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/vn-2sub.json"
}

else{

    Write-Host "VIRTUALNETWORK $vnet already exist"

}

Write-Output `n "======================================================================================" 
Write-Output    "==================================   Creating NSG   ==================================" 
Write-Output    "======================================================================================" `n

$check = Get-AzNetworkSecurityGroup -Name $nsgpbl -ErrorAction SilentlyContinue

if($check -eq $null){

New-AzResourceGroupDeployment `
  -Name remoteTemplateDeployment `
  -ResourceGroupName $rg `
  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/nsg.json" `
  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/nsgPbl.json"
  
}

else{

    Write-Host "NSG: $nsgpbl already exist"

}

Write-Output    "===================================  On progress  ====================================" 

$check = Get-AzNetworkSecurityGroup -Name $nsgpvt -ErrorAction SilentlyContinue

if($check -eq $null){

New-AzResourceGroupDeployment `
  -Name remoteTemplateDeployment `
  -ResourceGroupName $rg `
  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/nsg.json" `
  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/nsgPvt.json"
  
}

else{

    Write-Host "NSG: $nsgpvt already exist"

}

Write-Output `n "======================================================================================" 
Write-Output    "==============================  Creating VNetIntface  ================================" 
Write-Output    "======================================================================================" `n

$check = Get-AzNetworkInterface -Name 'vnicws10a' -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vnic-ip4.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/vnicws10a.json"
	  
}

else{

    Write-Host "VNICWS10A already exist"

}

Write-Output    "===================================  On progress  ====================================" 

$check = Get-AzNetworkInterface -Name 'vnicad19a' -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vnic-ip4.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/vnicad19a.json"
	  
}

else{

    Write-Host "VNICAD19A already exist"

}

Write-Output    "===================================  On progress  ====================================" 

$check = Get-AzNetworkInterface -Name 'vnicex19a' -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vnic-ip4.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/vnicex19a.json"
	  
}

else{

    Write-Host "VNICEX19A already exist"

}

Write-Output    "===================================  On progress  ====================================" 

$check = Get-AzNetworkInterface -Name 'vnichv19a' -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vnic-ip4.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/vnichv19a.json"
	  
}

else{

    Write-Host "VNICHV19A already exist"

}

Write-Output `n "======================================================================================" 
Write-Output    "================================     Creating VM      ================================" 
Write-Output    "======================================================================================" `n

$check = Get-AzVM -Name 'vmws10a' -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vm-pip-nodisk-osSize.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/vmws10a.json"
	  
}

else{

    Write-Host "VMWS10A already exist"

}

Write-Output    "===================================  On progress  ====================================" 

$check = Get-AzVM -Name 'vmad19a' -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vm-pip-nodisk-osSize.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/vmad19a.json"
	  
}

else{

    Write-Host "VMAD19A already exist"

}

Write-Output    "===================================  On progress  ====================================" 

$check = Get-AzVM -Name 'vmex19a' -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vm-pip-nodisk-osSize.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/vmex19a.json"
	  
}

else{

    Write-Host "VMEX19A already exist"

}

Write-Output    "===================================  On progress  ====================================" 

$check = Get-AzVM -Name 'vmhv19a' -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vm-pip-nodisk-osSize.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/vmhv19a.json"
	  
}

else{

    Write-Host "VMHV19A already exist"

}

Write-Output `n "======================================================================================" 
Write-Output    "================================   Configuration RDP  ================================" 
Write-Output    "======================================================================================" `n

$script = Invoke-WebRequest "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/confscripts/nsg-rdp.ps1"
Invoke-Expression $($script.Content)

Write-Output `n "======================================================================================" 
Write-Output    "==============================   COMMAND IS: FINISHED   ==============================" 
Write-Output    "======================================================================================" `n