$lc = "eus" + "-"
$rg = $lc + "rg"
$loc = "eastus"
$post = "a"
$os = "ex19"

Write-Output `n "======================================================================================" 
Write-Output    "===============================  Creating PublicIPAdd ================================" 
Write-Output    "======================================================================================" `n

$pip = $lc + "pip" + $os + $post

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

$vnic = $lc + "vnic" + $os + $post

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

$vm = $lc + "vm" + $os + $post

$check = Get-AzVM -Name $vm -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vm-pip-nodisk-ps.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/$vm.json"
	  
}

else{

    Write-Host "$vm already exist"

}