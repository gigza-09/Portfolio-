# Downloads every image the site uses from Framer's CDN into ./assets
# Run once from the project folder:  powershell -ExecutionPolicy Bypass -File .\download-assets.ps1
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
New-Item -ItemType Directory -Force -Path assets | Out-Null
$urls = Get-Content assets-manifest.txt | Where-Object { $_.Trim() -ne "" }
$i = 0
foreach ($url in $urls) {
  $i++
  $name = Split-Path $url -Leaf
  $dest = Join-Path "assets" $name
  if (Test-Path $dest) { Write-Host "[$i/$($urls.Count)] skip $name"; continue }
  Write-Host "[$i/$($urls.Count)] $name"
  Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing
}
Write-Host "Done. $($urls.Count) images in .\assets"
