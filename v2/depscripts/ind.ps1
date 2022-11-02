$nsg = 'eus-nsgPbl'

$check = Get-AzNetworkSecurityGroup -Name $nsg -ErrorAction SilentlyContinue

if($check -eq $null){

New-AzResourceGroupDeployment `
  -Name remoteTemplateDeployment `
  -ResourceGroupName $rg `
  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/nsg.json" `
  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/eus-nsgPbl.json"
  
}

else{

    Write-Host "NSG: $nsgPbl already exist"

}