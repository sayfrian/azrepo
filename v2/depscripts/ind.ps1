$vpn = 'eus-vpn'

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