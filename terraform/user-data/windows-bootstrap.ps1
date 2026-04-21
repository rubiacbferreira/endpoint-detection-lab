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

    # ================================
    # 🔥 DOWNLOAD SIMULATION SCRIPTS
    # ================================
    Write-Output "[+] Downloading simulation scripts"

    $base = "https://raw.githubusercontent.com/rubiacbferreira/endpoint-detection-lab/main/simulations/windows"

    Invoke-WebRequest "$base/suspicious_process.ps1" -OutFile "C:\Lab\suspicious_process.ps1"
    Invoke-WebRequest "$base/persistence.ps1" -OutFile "C:\Lab\persistence.ps1"
    Invoke-WebRequest "$base/network_activity.ps1" -OutFile "C:\Lab\network_activity.ps1"

    # ================================
    # 🚀 RUN SIMULATIONS
    # ================================
    Write-Output "[+] Running simulations"

    cd C:\Lab

    .\suspicious_process.ps1
    .\persistence.ps1
    .\network_activity.ps1

    Start-Sleep -Seconds 5

    Write-Output "[+] Generating detection evidence"

    & "C:\Program Files\osquery\osqueryi.exe" `
        "select * from file where path = 'C:\Lab\index.html';" `
        | Out-File "C:\Lab\detection-result.json"

    # ================================
    # ✅ FINAL STATUS
    # ================================
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