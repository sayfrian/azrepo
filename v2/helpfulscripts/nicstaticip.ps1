$msg = 'DETACH NEW VNIC'
Write-Output `n "==================================================================" 
Write-Output    "Started: " + $msg 
Write-Output    "==================================================================" `n

$lc = 'eus-'
$rg = $lc + 'rg'
$post = 'a'
$os = 'ws10'
$nic = $lc + 'vnic' + $os + $post
$privateip = '10.0.0.12'

$nic = Get-AzNetworkInterface -Name $nic -ResourceGroupName $rg

$net = @{
    Name = $lc + 'vnet'
    ResourceGroupName = $rg
}
$vnet = Get-AzVirtualNetwork @net

## Place subnet configuration into a variable. ##
$sub = @{
    Name = $lc + 'vnetpbl'
    VirtualNetwork = $vnet
}
$subnet = Get-AzVirtualNetworkSubnetConfig @sub

#change IP of the current VNIC
$config =@{
    Name = $config
    PrivateIpAddress = $privateip
    Subnet = $subnet
}
$nic | Set-AzNetworkInterfaceIpConfig @config -Primary

## Save interface configuration. ##
$nic | Set-AzNetworkInterface

Write-Output `n "==================================================================" 
Write-Output    "Completed: " + $msg
Write-Output    "==================================================================" `n