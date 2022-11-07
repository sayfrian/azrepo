$lc = 'eus-'
$rg = $lc + 'rg'
$post = 'a'
$oldvnic = 'vnicws10' + $post
$pip = $lc + 'pipws10' + $post
$vmName = $lc + 'vmws10' + $post
$privateip = '10.0.0.12'

$onic = Get-AzNetworkInterface -Name $oldvnic -ResourceGroupName $rg
$newvnic = $lc + $oldvnic
$nnic = Get-AzNetworkInterface -Name $newvnic -ResourceGroupName $rg

#detach from public ip
$onic.IpConfigurations.publicipaddress.id = $null
Set-AzNetworkInterface -NetworkInterface $onic




$newnicId = $nnic.Id
$oldnicId = $onic.Id

#detach from VM
$vm = Get-AzVm -Name $vmName -ResourceGroupName $rg
Add-AzVMNetworkInterface -VM $vm -NetworkInterfaceID $newnicId -Primary | Update-AzVm -ResourceGroupName $rg
Remove-AzVMNetworkInterface -VM $vm -NetworkInterfaceID $oldnicId | Update-AzVm -ResourceGroupName $rg




$pip = Get-AzPublicIpAddress -Name $pip -ResourceGroup $rg
$pipId = $pip.id
$config = Get-AzNetworkInterfaceipConfig -NetworkInterface $nnic
$config = $config.name

#attach to public ip
$nnic | Set-AzNetworkInterfaceIpConfig -Name $config -PublicIPAddress $pip
$nnic | Set-AzNetworkInterface




#remove old NIC
Remove-AzNetworkInterface -Name $oldvnic -ResourceGroup $rg -Force




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
$nnic | Set-AzNetworkInterfaceIpConfig @config -Primary

## Save interface configuration. ##
$nnic | Set-AzNetworkInterface