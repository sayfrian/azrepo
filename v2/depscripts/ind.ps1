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