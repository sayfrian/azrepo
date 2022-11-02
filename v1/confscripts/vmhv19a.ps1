Write-Output `n "=========================  Creating Folder TEMP Downloads ============================" `n

cd C:\
mkdir "TEMP Downloads"

Write-Output `n "===========================  Download Windows 2019 iso  ==============================" `n

$URL = "https://software-static.download.prss.microsoft.com/pr/download/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso"
$Path= "C:\TEMP Downloads\netfw_4-8.exe"
(New-Object System.Net.WebClient).DownloadFile($URL, $Path)