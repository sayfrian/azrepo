$msg = 'REMOVE IPCONFIG'
Write-Output `n "==================================================================" 
Write-Output    "Started: " + $msg 
Write-Output    "==================================================================" `n

$lc = 'sea-'
$rg = $lc + 'rg'
$post = 'a'
$os = 'ad19'
$nic = $lc + 'vnic' + $os + $post
$config = 'ipconfig2'

$nic = Get-AzNetworkInterface -Name $nic -ResourceGroupName $rg

#change IP of the current VNIC
$config =@{
    Name = $config
}
$nic | Remove-AzNetworkInterfaceIpConfig @config

## Save interface configuration. ##
$nic | Set-AzNetworkInterface

Write-Output `n "==================================================================" 
Write-Output    "Completed: " + $msg
Write-Output    "==================================================================" `n