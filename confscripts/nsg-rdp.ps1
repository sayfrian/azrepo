$nsgnames = @('nsgPbl')
$rulename = "allow RDP"
$ruledesc = "allow RDP to connect to the server"
$ruleport = 3389
$getownip = (Invoke-WebRequest -uri "https://ipinfo.io/ip").Content


function AddOrUpdateRDPRecord {lllll
    Process {
        $nsg = Get-AzNetworkSecurityGroup -Name $_
        $ruleexists = (Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $nsg).Name.Contains($rulename);

        if($ruleexists)
        {
            # Update the existing rule with the new IP address
            Set-AzNetworkSecurityRuleConfig `
                -Name $rulename `
                -Description $ruledesc `
                -Access Allow `
                -Protocol TCP `
                -Direction Inbound `
                -Priority 100 `
                -SourceAddressPrefix $getownip `
                -SourcePortRange * `
                -DestinationAddressPrefix * `
                -DestinationPortRange $ruleport `
                -NetworkSecurityGroup $nsg
        }
        else
        {
            # Create a new rule
            $nsg | Add-AzNetworkSecurityRuleConfig `
                -Name $rulename `
                -Description $ruledesc `
                -Access Allow `
                -Protocol TCP `
                -Direction Inbound `
                -Priority 100 `
                -SourceAddressPrefix $getownip `
                -SourcePortRange * `
                -DestinationAddressPrefix * `
                -DestinationPortRange $ruleport
        }

        # Save changes to the NSG
        $nsg | Set-AzNetworkSecurityGroup
    }
}

$nsgnames | AddOrUpdateRDPRecord
