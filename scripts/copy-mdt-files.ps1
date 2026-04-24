# Run this on the Windows Server after MDT has generated its boot images.
# It stages the three files needed by wimboot into C:\MDT-PXE-Export\.
#
# Prerequisites on this server:
#   - Windows ADK installed (for BCD and boot.sdi)
#   - Windows ADK WinPE Addon installed
#   - MDT installed and deployment share updated at least once
#
# After running this, go to the Docker host and run scripts/pull-mdt-files.sh

param(
    [string]$DeploymentShare = "C:\DeploymentShare",
    [string]$ExportPath      = "C:\MDT-PXE-Export"
)

$ADKWinPE = "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\Media\Boot"

if (-not (Test-Path $ADKWinPE)) {
    Write-Error "Windows ADK WinPE path not found: $ADKWinPE`nInstall Windows ADK + WinPE Addon and try again."
    exit 1
}

$WimSource = "$DeploymentShare\Boot\LiteTouchPE_x64.wim"
if (-not (Test-Path $WimSource)) {
    Write-Error "LiteTouchPE_x64.wim not found at $WimSource`nOpen MDT Deployment Workbench, right-click your deployment share, and choose 'Update Deployment Share'."
    exit 1
}

New-Item -ItemType Directory -Force -Path $ExportPath | Out-Null

Write-Host "Copying BCD..."
Copy-Item "$ADKWinPE\BCD"      "$ExportPath\BCD"      -Force

Write-Host "Copying boot.sdi..."
Copy-Item "$ADKWinPE\boot.sdi" "$ExportPath\boot.sdi" -Force

Write-Host "Copying LiteTouchPE_x64.wim (this may take a moment)..."
Copy-Item $WimSource "$ExportPath\LiteTouchPE_x64.wim" -Force

Write-Host ""
Write-Host "Done. Files staged at $ExportPath"
Write-Host "Now run scripts/pull-mdt-files.sh on the Docker host."
