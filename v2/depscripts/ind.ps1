$vm = 'eus-vmad19a'

$check = Get-AzVM -Name $vm -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vm-nopip-nodisk-ps.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/eus-vmad19a.json"
	  
}

else{

    Write-Host "$vm already exist"

}