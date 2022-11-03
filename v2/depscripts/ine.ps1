$pip = 'eus-pipws10a'
$rg = 'eus-rg'

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

$vnic = 'eus-vnicws10a'

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

$rg = 'eus-rg'
$vm = 'eus-vmws10a'

$check = Get-AzVM -Name $vm -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vm-pip-nodisk.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/eus-vmws10a.json"
	  
}

else{

    Write-Host "$vm already exist"

}