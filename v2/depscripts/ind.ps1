$nsg = 'eus-nsgPvt'

$check = Get-AzNetworkSecurityGroup -Name $nsg -ErrorAction SilentlyContinue

if($check -eq $null){

New-AzResourceGroupDeployment `
  -Name remoteTemplateDeployment `
  -ResourceGroupName $rg `
  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/nsg.json" `
  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/eus-nsgPvt.json"
  
}

else{

    Write-Host "NSG: $nsg already exist"

}