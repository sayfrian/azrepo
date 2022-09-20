$nsgnames = @('nsgPbl')
$rulename = "allow SMTP25"
$ruledesc = "allow SMTP25 to the internet"
$ruleport = 25
$getownip = (Invoke-WebRequest -uri "https://ipinfo.io/ip").Content


function AddOrUpdateRDPRecord {
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
                -Direction Outbound `
                -Priority 125 `
                -SourceAddressPrefix * `
                -SourcePortRange $ruleport `
                -DestinationAddressPrefix * `
                -DestinationPortRange `
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
                -Direction Outbound `
                -Priority 125 `
                -SourceAddressPrefix * `
                -SourcePortRange $ruleport `
                -DestinationAddressPrefix * `
                -DestinationPortRange 
        }

        # Save changes to the NSG
        $nsg | Set-AzNetworkSecurityGroup
    }
}

$nsgnames | AddOrUpdateRDPRecord