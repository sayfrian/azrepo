Write-Output `n "======================================================================================" 
Write-Output    "===============================  Creating PublicIPAdd ================================" 
Write-Output    "======================================================================================" `n 

$pip = 'eus-pipad19a'

$check = Get-AzPublicIpAddress -Name $pip -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/pipBsc.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/eus-pipad19a.json"
	  
}

else{

    Write-Host " $pip already exist"

}

Write-Output    "===================================  On progress  ===================================="

$pip = 'eus-pipws10a'

$check = Get-AzPublicIpAddress -Name $pip -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/pipBsc.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/eus-pipws10a.json"
	  
}

else{

    Write-Host " $pip already exist"

}

Write-Output    "===================================  On progress  ===================================="

$pip = 'eus-pipws10b'

$check = Get-AzPublicIpAddress -Name $pip -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/pipBsc.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/eus-pipws10b.json"
	  
}

else{

    Write-Host " $pip already exist"

}