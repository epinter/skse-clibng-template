param([string]$buildType="ALL-release", [string]$preset="ALL")
$ErrorActionPreference = "Stop"
Set-StrictMode -Version 3.0

Write-Warning "Using buildType='$buildType' and preset='$preset'"

$projectRoot = Resolve-Path "$PSScriptRoot/.."

Set-Location $projectRoot
cmake -B build -S "$projectRoot" --preset $preset --fresh
cmake --build "$projectRoot/build" --preset "$($buildType)"
cmake --build "$projectRoot/build" --preset "$($buildType)" --install
Set-Location "$projectRoot/build"
cpack
Set-Location $projectRoot
