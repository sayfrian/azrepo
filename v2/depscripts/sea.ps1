Write-Output `n "================================ ENVIRONMENT CREATION ================================"

Write-Output `n "======================================================================================" 
Write-Output    "================================  Creating  RG: sea   ================================" 
Write-Output    "======================================================================================" `n

$rg = "sea-rg"
$loc = "southeastasia"

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

$vnet = "sea-vnet"

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

$nsg = 'sea-nsgpbl'

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

$nsg = 'sea-nsgpvt'

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

$pip = 'sea-pipws10a'

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

$pip = 'sea-pipws10b'

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

$pip = 'sea-pipvpna'

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

$pip = 'sea-pipvpnb'

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
Write-Output    "==============================  Creating VPN Network  ================================" 
Write-Output    "======================================================================================" `n

$vpn = 'sea-vpn'

$check = Get-AzPublicIpAddress -Name $vpn -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vpn-act-nobgp.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/$vpn.json"
	  
}

else{

    Write-Host " $vpn already exist"

}

Write-Output `n "======================================================================================" 
Write-Output    "==============================  Creating VNetIntface  ================================" 
Write-Output    "======================================================================================" `n

$vnic = 'sea-vnicad19a'

$check = Get-AzNetworkInterface -Name $vnic -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vnic-ip4.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/$vnic.json"
	  
}

else{

    Write-Host "$vnic already exist"

}

Write-Output    "===================================  On progress  ====================================" 

$vnic = 'sea-vnicws10a'

$check = Get-AzNetworkInterface -Name $vnic -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vnic-ip4.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/$vnic.json"
	  
}

else{

    Write-Host "$vnic already exist"

}

Write-Output    "===================================  On progress  ====================================" 

$vnic = 'sea-vnicws10b'

$check = Get-AzNetworkInterface -Name $vnic -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vnic-ip4.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/$vnic.json"
	  
}

else{

    Write-Host "$vnic already exist"

}

Write-Output `n "======================================================================================" 
Write-Output    "================================     Creating VM      ================================" 
Write-Output    "======================================================================================" `n

$vm = 'sea-vmad19a'

$check = Get-AzVM -Name $vm -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vm-nopip-nodisk-ps.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/sea-vmad19a.json"
	  
}

else{

    Write-Host "$vm already exist"

}

Write-Output    "===================================  On progress  ====================================" 

$vm = 'sea-vmws10a'

$check = Get-AzVM -Name $vm -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vm-pip-nodisk.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/sea-vmws10a.json"
	  
}

else{

    Write-Host "$vm already exist"

}

Write-Output    "===================================  On progress  ====================================" 

$vm = 'sea-vmws10b'

$check = Get-AzVM -Name $vm -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vm-pip-nodisk.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/sea-vmws10b.json"
	  
}

else{

    Write-Host "$vm already exist"

}