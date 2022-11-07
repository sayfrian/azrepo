$lc = 'sea-'
$rg = $lc + 'rg'
$post = 'a'
$oldvnic = 'vnicws10' + $post
$pip = $lc + 'pipws10' + $post
$vmName = $lc + 'vmws10' + $post
$newvnic = $lc + 'vnicws10' + $post
$privateip = '11.0.0.11'

$nnic = Get-AzNetworkInterface -Name $newvnic -ResourceGroupName $rg
#$nnic

$net = @{
    Name = $lc + 'vnet'
    ResourceGroupName = $rg
}
$vnet = Get-AzVirtualNetwork @net
#$vnet


$config = Get-AzNetworkInterfaceipConfig -NetworkInterface $nnic
$config = $config.name
#$config

## Place subnet configuration into a variable. ##
$sub = @{
    Name = $lc + 'vnetpbl'
    VirtualNetwork = $vnet
}
$subnet = Get-AzVirtualNetworkSubnetConfig @sub
#$subnet

#change IP of the current VNIC
$config =@{
    Name = $config
    PrivateIpAddress = $privateip
    Subnet = $subnet
}
$nnic | Set-AzNetworkInterfaceIpConfig @config -Primary

## Save interface configuration. ##
$nnic | Set-AzNetworkInterface