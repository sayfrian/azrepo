#RUN THIS SCRIPTS ONLY IN EXCHANGE POWERSHELL, AND THIS STEPS IS OPTIONAL
Write-Output `n "======================================================================================" 
Write-Output    "========================  Activate Exchange Server (if any)  =========================" 
Write-Output    "======================================================================================" `n

Get-ExchangeServer
Set-ExchangeServer "NAME" -ProductKey XXXXX-XXXXX-XXXXX-XXXXX
Restart-Service "MSExchangeIS"
Get-ExchangeServer "NAME" | ft Name,Edition,ProductID,IsExchangeTrialEdition -Auto

Write-Output `n "======================================================================================" 
Write-Output    "==========================  Change Database Exchange Name  ===========================" 
Write-Output    "======================================================================================" `n

Get-MailboxDatabase
Set-MailboxDatabase "Mailbox Database XXXXXXXXXX" -Name "DB01"
Get-MailboxDatabase

Write-Output `n "======================================================================================" 
Write-Output    "==========================  Move Database to Another Drive  ==========================" 
Write-Output    "======================================================================================" `n


Write-Output `n "=======================  In this case E: for DB, F: for Logs  ========================" `n

Move-DatabasePath "DB01" -EdbFilePath "E:\DB01\DB01.edb" -LogFolderPath "F:\DB01"


Write-Output `n "===========================  Remove old/default database  ============================" `n

rmdir "C:\Program Files\Microsoft\Exchange Server\V15\Mailbox" -Force

#IN CASE YOU GET NOTIFICATIONS ERROR ON REMOVING OLD/DEFAULT DATABASE
Get-Service -Name "HostControllerService","MSExchangeFastSearch" | Restart-Service

#VERIFY THE RESULT
Write-Output `n "======================================  Results  =====================================" `n
Get-MailboxDatabase | Format-List Name, EdbFilePath, LogFolderPath