# update_flutter_env.ps1
# Safely prepend D:\flutter\bin to HKCU\Environment Path and set FLUTTER_ROOT for current user.
$current = (Get-ItemProperty -Path 'HKCU:\Environment' -Name Path -ErrorAction SilentlyContinue).Path
if ($current -eq $null) { $current = '' }
if ($current -notlike '*D:\flutter\bin*') {
    Set-ItemProperty -Path 'HKCU:\Environment' -Name Path -Value ("D:\\flutter\\bin;" + $current)
}
[Environment]::SetEnvironmentVariable('FLUTTER_ROOT','D:\flutter','User')
# Update this shell's PATH so subsequent commands in this script can use flutter immediately.
if ($env:Path -notlike '*D:\flutter\bin*') { $env:Path = 'D:\flutter\bin;' + $env:Path }
Write-Host 'User env vars saved and current shell PATH updated.'
Write-Host '---- flutter version ----'
flutter --version
Write-Host '---- running flutter clean & pub get ----'
# Change to project directory if it exists
if (Test-Path 'D:\Kiro\Pillow bud\pillow_bud') {
    Set-Location 'D:\Kiro\Pillow bud\pillow_bud'
    flutter clean
    flutter pub get
} else {
    Write-Host 'Project path not found: D:\Kiro\Pillow bud\pillow_bud'
}
Write-Host 'Script finished. Restart your shells/IDE to pick up the user PATH in new terminals.'
