$msg = 'DETACH OLD PIP'
Write-Output `n "==================================================================" 
Write-Output    "Started: " + $msg 
Write-Output    "==================================================================" `n

$lc = 'eus-'
$rg = $lc + 'rg'
$post = 'a'
$os = 'ws10'
$nic = 'vnic' + $os + $post

$nic = Get-AzNetworkInterface -Name $nic -ResourceGroupName $rg
$nic.IpConfigurations.publicipaddress.id = $null
Set-AzNetworkInterface -NetworkInterface $nic

Write-Output `n "==================================================================" 
Write-Output    "Completed: " + $msg
Write-Output    "==================================================================" `n