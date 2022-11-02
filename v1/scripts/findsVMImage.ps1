#Example: Windows 10

$loc = 'eastus'
$pub = 'MicrosoftWindowsDesktop'
$off = 'Windows-10'
$sku = 'win10-21h2-pro'

#To get the publisher list
Get-AzVMImagePublisher -location $loc

#To get the offer list
Get-AzVMImageOffer -location $loc -Publisher $pub

#To get the sku list
Get-AzVMImageSku -location $loc -Publisher $pub -Offer $off

#To get the available image version
Get-AzVMImage -location $loc -Publisher $pub -Offer $off -Sku $sku

<#=======================================================#>
<#=======================================================#>
<#=======================================================#>

#Example: Windows Server 2019

$loc = 'eastus'
$pub = 'MicrosoftWindowsServer'
$off = 'WindowsServer'
$sku = 'win10-21h2-pro'

#To get the publisher list
Get-AzVMImagePublisher -location $loc

#To get the offer list
Get-AzVMImageOffer -location $loc -Publisher $pub

#To get the sku list
Get-AzVMImageSku -location $loc -Publisher $pub -Offer $off

#To get the available image version
Get-AzVMImage -location $loc -Publisher $pub -Offer $off -Sku $sku

<#=======================================================#>
<#=======================================================#>
<#=======================================================#>

#Example: Windows 11

$loc = 'eastus'
$pub = 'MicrosoftWindowsDesktop'
$off = 'Windows-11'
$sku = 'win11-21h2-pro'

#To get the publisher list
Get-AzVMImagePublisher -location $loc

#To get the offer list
Get-AzVMImageOffer -location $loc -Publisher $pub

#To get the sku list
Get-AzVMImageSku -location $loc -Publisher $pub -Offer $off

#To get the available image version
Get-AzVMImage -location $loc -Publisher $pub -Offer $off -Sku $sku

<#=======================================================#>
<#=======================================================#>
<#=======================================================#>

#Example: Linux RedHat

$loc = 'eastus'
$pub = 'Redhat'
$off = 'RHEL'
$sku = '8.2'

#To get the publisher list
Get-AzVMImagePublisher -location $loc

#To get the offer list
Get-AzVMImageOffer -location $loc -Publisher $pub

#To get the sku list
Get-AzVMImageSku -location $loc -Publisher $pub -Offer $off

#To get the available image version
Get-AzVMImage -location $loc -Publisher $pub -Offer $off -Sku $sku

<#=======================================================#>
<#=======================================================#>
<#=======================================================#>

#Example: Linux CentOS

$loc = 'eastus'
$pub = 'OpenLogic'
$off = 'CentOS'
$sku = '8_2'

#To get the publisher list
Get-AzVMImagePublisher -location $loc

#To get the offer list
Get-AzVMImageOffer -location $loc -Publisher $pub

#To get the sku list
Get-AzVMImageSku -location $loc -Publisher $pub -Offer $off

#To get the available image version
Get-AzVMImage -location $loc -Publisher $pub -Offer $off -Sku $sku

<#=======================================================#>
<#=======================================================#>
<#=======================================================#>

#Example: Linux Ubuntu

$loc = 'eastus'
$pub = 'Canonical'
$off = 'UbuntuServer'
$sku = '14.04.5-LTS'

#To get the publisher list
Get-AzVMImagePublisher -location $loc

#To get the offer list
Get-AzVMImageOffer -location $loc -Publisher $pub

#To get the sku list
Get-AzVMImageSku -location $loc -Publisher $pub -Offer $off

#To get the available image version
Get-AzVMImage -location $loc -Publisher $pub -Offer $off -Sku $sku

<#=======================================================#>
<#=======================================================#>
<#=======================================================#>

#Example: Linux Debian

$loc = 'eastus'
$pub = 'Debian'
$off = 'debian-11'
$sku = '11-gen2'

#To get the publisher list
Get-AzVMImagePublisher -location $loc

#To get the offer list
Get-AzVMImageOffer -location $loc -Publisher $pub

#To get the sku list
Get-AzVMImageSku -location $loc -Publisher $pub -Offer $off

#To get the available image version
Get-AzVMImage -location $loc -Publisher $pub -Offer $off -Sku $sku

<#=======================================================#>
<#=======================================================#>
<#=======================================================#>

#Example: Linux SUSE

$loc = 'eastus'
$pub = 'SUSE'
$off = 'SLES'
$sku = '12-sp4-gen2'

#To get the publisher list
Get-AzVMImagePublisher -location $loc

#To get the offer list
Get-AzVMImageOffer -location $loc -Publisher $pub

#To get the sku list
Get-AzVMImageSku -location $loc -Publisher $pub -Offer $off

#To get the available image version
Get-AzVMImage -location $loc -Publisher $pub -Offer $off -Sku $sku