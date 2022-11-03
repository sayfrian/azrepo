$vnic = 'eus-vnicad19a'

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

$vnic = 'eus-vnicws10b'

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