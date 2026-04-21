<powershell>
$ErrorActionPreference = "Stop"
Start-Transcript -Path "C:\ProgramData\Amazon\EC2-Windows\Launch\Log\UserdataExecution.log" -Append

try {
    New-Item -ItemType Directory -Force -Path "C:\Lab" | Out-Null
    New-Item -ItemType Directory -Force -Path "C:\Lab\Logs" | Out-Null
    New-Item -ItemType Directory -Force -Path "C:\Lab\Tools" | Out-Null

    # Optional: rename hostname
    Rename-Computer -NewName "lab-win-01" -Force

    # Download and install osquery MSI
    $msiPath = "C:\Lab\Tools\osquery.msi"
    Invoke-WebRequest -Uri "https://pkg.osquery.io/windows/osquery-5.15.0.msi" -OutFile $msiPath

    Start-Process msiexec.exe -ArgumentList "/i `"$msiPath`" /qn" -Wait

    Start-Service osqueryd -ErrorAction SilentlyContinue
    Set-Service -Name osqueryd -StartupType Automatic -ErrorAction SilentlyContinue

    "Windows bootstrap completed successfully on $(Get-Date)" | Out-File -FilePath "C:\Lab\bootstrap-status.txt" -Encoding utf8
}
catch {
    $_ | Out-File -FilePath "C:\Lab\bootstrap-error.txt" -Encoding utf8
    throw
}
finally {
    Stop-Transcript
}
</powershell>