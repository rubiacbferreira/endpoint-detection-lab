Write-Output "[+] Creating persistence"

$regPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run"

# Create path if it doesn't exist
if (!(Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

New-ItemProperty `
  -Path $regPath `
  -Name "LabPersistence" `
  -Value "notepad.exe" `
  -PropertyType String `
  -Force

Write-Output "[+] Done"