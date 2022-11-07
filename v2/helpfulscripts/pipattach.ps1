$msg = 'ATTACH NEW PIP'
Write-Output `n "==================================================================" 
Write-Output    "Started: " + $msg 
Write-Output    "==================================================================" `n

$lc = 'eus-'
$rg = $lc + 'rg'
$post = 'a'
$os = 'ws10'
$nic = 'vnic' + $os + $post

$nic = Get-AzNetworkInterface -Name $nic -ResourceGroupName $rg
$pip = Get-AzPublicIpAddress -Name $pip -ResourceGroup $rg
$config = Get-AzNetworkInterfaceipConfig -NetworkInterface $nic
$config = $config.name

#attach to public ip
$nic | Set-AzNetworkInterfaceIpConfig -Name $config -PublicIPAddress $pip
$nic | Set-AzNetworkInterface

Write-Output `n "==================================================================" 
Write-Output    "Completed: " + $msg
Write-Output    "==================================================================" `n