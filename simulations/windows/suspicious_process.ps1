Write-Output "[+] Simulating suspicious process execution"

Start-Process powershell.exe
Start-Process cmd.exe

Start-Sleep 2

Write-Output "[+] Done"