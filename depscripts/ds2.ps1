$rg = "pavilico"
$loc = "eastus"

Write-Output `n "================================ ENVIRONMENT CREATION ================================"

Write-Output `n "======================================================================================" 
Write-Output    "================================  Creating RG: pavilico   ================================" 
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

$check = Get-AzVirtualNetwork -Name 'vnetpavilico' -ErrorAction SilentlyContinue

if($check -eq $null){
	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/templates/vn-1sub.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/parameters/vneta.json"
}

else{

    Write-Host "VIRTUALNETWORK already exist"

}

Write-Output `n "======================================================================================" 
Write-Output    "==================================   Creating NSG   ==================================" 
Write-Output    "======================================================================================" `n

$check = Get-AzNetworkSecurityGroup -Name 'nsgPbl' -ErrorAction SilentlyContinue

if($check -eq $null){

New-AzResourceGroupDeployment `
  -Name remoteTemplateDeployment `
  -ResourceGroupName $rg `
  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/templates/nsg.json" `
  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/parameters/nsgPbl.json"
  
}

else{

    Write-Host "NSGPBL already exist"

}

Write-Output `n "======================================================================================" 
Write-Output    "===========================  Creating VNetIntface-UBT01A  =============================" 
Write-Output    "======================================================================================" `n

$check = Get-AzNetworkInterface -Name 'vnicubt16a' -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/pavilico/master/vnic.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/parameters/vnicubt22a.json"
	  
}

else{

    Write-Host "VNICUBT01A already exist"

}

Write-Output `n "======================================================================================" 
Write-Output    "================================   Creating VM-UBT16A  ================================" 
Write-Output    "======================================================================================" `n

$check = Get-AzVM -Name 'vmubt16a' -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/pavilico/master/vmubt16.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/pavilico/master/vmubt16a.json"
	  
}

else{

    Write-Host "VMUBT01A already exist"

}

Write-Output `n "======================================================================================" 
Write-Output    "================================   Configuration SSH  ================================" 
Write-Output    "======================================================================================" `n

$script = Invoke-WebRequest "https://raw.githubusercontent.com/sayfuladrian/pavilico/master/scriptconfnsg.ps1"
Invoke-Expression $($script.Content)

Write-Output `n "======================================================================================" 
Write-Output    "==============================   COMMAND IS: FINISHED   ==============================" 
Write-Output    "======================================================================================" `n