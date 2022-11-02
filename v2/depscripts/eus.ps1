Write-Output `n "================================ ENVIRONMENT CREATION ================================"

Write-Output `n "======================================================================================" 
Write-Output    "================================  Creating  RG: EUS   ================================" 
Write-Output    "======================================================================================" `n

$rg = "eus-rg"
$loc = "eastus"

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

$vnet = "eus-vnet"

$check = Get-AzVirtualNetwork -Name $vnet -ErrorAction SilentlyContinue

if($check -eq $null){
	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vn-2sub.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/$vnet.json"
}

else{

    Write-Host "VIRTUALNETWORK $vnet already exist"

}

Write-Output `n "======================================================================================" 
Write-Output    "==================================   Creating NSG   ==================================" 
Write-Output    "======================================================================================" `n

$nsg = 'eus-nsgpbl'

$check = Get-AzNetworkSecurityGroup -Name $nsg -ErrorAction SilentlyContinue

if($check -eq $null){

New-AzResourceGroupDeployment `
  -Name remoteTemplateDeployment `
  -ResourceGroupName $rg `
  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/nsg.json" `
  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/$nsg.json"
  
}

else{

    Write-Host "NSG: $nsg already exist"

}

Write-Output    "===================================  On progress  ====================================" 

$nsg = 'eus-nsgpvt'

$check = Get-AzNetworkSecurityGroup -Name $nsg -ErrorAction SilentlyContinue

if($check -eq $null){

New-AzResourceGroupDeployment `
  -Name remoteTemplateDeployment `
  -ResourceGroupName $rg `
  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/nsg.json" `
  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/$nsg.json"
  
}

else{

    Write-Host "NSG: $nsg already exist"

}

Write-Output `n "======================================================================================" 
Write-Output    "===============================  Creating PublicIPAdd ================================" 
Write-Output    "======================================================================================" `n 

$pip = 'eus-pipad19a'

$check = Get-AzPublicIpAddress -Name $pip -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/pipBsc.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/$pip.json"
	  
}

else{

    Write-Host " $pip already exist"

}

Write-Output    "===================================  On progress  ===================================="

$pip = 'eus-pipws10a'

$check = Get-AzPublicIpAddress -Name $pip -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/pipBsc.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/$pip.json"
	  
}

else{

    Write-Host " $pip already exist"

}

Write-Output    "===================================  On progress  ===================================="

$pip = 'eus-pipws10b'

$check = Get-AzPublicIpAddress -Name $pip -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/pipBsc.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/$pip.json"
	  
}

else{

    Write-Host " $pip already exist"

}

Write-Output    "===================================  On progress  ===================================="

$pip = 'eus-pipvpna'

$check = Get-AzPublicIpAddress -Name $pip -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/pipBsc.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/$pip.json"
	  
}

else{

    Write-Host " $pip already exist"

}

Write-Output    "===================================  On progress  ===================================="

$pip = 'eus-pipvpnb'

$check = Get-AzPublicIpAddress -Name $pip -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/pipBsc.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/$pip.json"
	  
}

else{

    Write-Host " $pip already exist"

}

Write-Output `n "======================================================================================" 
Write-Output    "==============================  Creating VNetIntface  ================================" 
Write-Output    "======================================================================================" `n

$vnic = 'eus-vnicad19a'

$check = Get-AzNetworkInterface -Name $vnic -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vnic-ip4.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/eus-vnicad19a.json"
	  
}

else{

    Write-Host "$vnic already exist"

}

Write-Output    "===================================  On progress  ====================================" 

$vnic = 'eus-vnicws10a'

$check = Get-AzNetworkInterface -Name $vnic -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vnic-ip4.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/eus-vnicws10a.json"
	  
}

else{

    Write-Host "$vnic already exist"

}

Write-Output    "===================================  On progress  ====================================" 

$vnic = 'eus-vnicws10b'

$check = Get-AzNetworkInterface -Name $vnic -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vnic-ip4.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/eus-vnicws10b.json"
	  
}

else{

    Write-Host "$vnic already exist"

}

Write-Output `n "======================================================================================" 
Write-Output    "================================     Creating VM      ================================" 
Write-Output    "======================================================================================" `n

$vm = 'eus-vmad19a'

$check = Get-AzVM -Name $vm -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/templates/vm-pip-nodisk-wsext.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/parameters/eus-vmad19a.json"
	  
}

else{

    Write-Host "$vm already exist"

}

Write-Output    "===================================  On progress  ====================================" 

$vm = 'eus-vmws10a'

$check = Get-AzVM -Name $vm -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/templates/vm-pip-nodisk.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/parameters/eus-vmws10a.json"
	  
}

else{

    Write-Host "$vm already exist"

}

Write-Output    "===================================  On progress  ====================================" 

$vm = 'eus-vmws10b'

$check = Get-AzVM -Name $vm -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/templates/vm-pip-nodisk.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/parameters/eus-vmws10b.json"
	  
}

else{

    Write-Host "$vm already exist"

}