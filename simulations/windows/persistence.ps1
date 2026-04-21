Write-Output "[+] Creating persistence"

New-ItemProperty `
  -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" `
  -Name "LabPersistence" `
  -Value "notepad.exe"

Write-Output "[+] Done"