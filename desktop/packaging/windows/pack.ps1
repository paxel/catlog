# Packs the Windows release from a built binary: a zip with catlog.exe,
# the licences and the icon. The Scoop manifest registers the .catsync
# file type on install.
#
#   packaging/windows/pack.ps1 -Version 2.0.0 -Binary target\release\catlog.exe -Dist dist
param(
  [Parameter(Mandatory = $true)][string]$Version,
  [Parameter(Mandatory = $true)][string]$Binary,
  [Parameter(Mandatory = $true)][string]$Dist
)
$ErrorActionPreference = "Stop"
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$root = Resolve-Path (Join-Path $here "..\..\..")
New-Item -ItemType Directory -Force $Dist | Out-Null
$stage = Join-Path ([System.IO.Path]::GetTempPath()) ("catlog-" + [System.Guid]::NewGuid())
New-Item -ItemType Directory -Force $stage | Out-Null
Copy-Item $Binary (Join-Path $stage "catlog.exe")
Copy-Item (Join-Path $root "LICENSE-APACHE") $stage -ErrorAction SilentlyContinue
Copy-Item (Join-Path $root "LICENSE-MIT") $stage -ErrorAction SilentlyContinue
Copy-Item (Join-Path $root "desktop\THIRD-PARTY.md") $stage
Copy-Item (Join-Path $root "assets\icon\icon.png") (Join-Path $stage "catlog.png")
Compress-Archive -Path (Join-Path $stage "*") -DestinationPath (Join-Path $Dist "catlog-$Version-windows-x86_64.zip") -Force
Remove-Item -Recurse -Force $stage
Get-ChildItem $Dist
