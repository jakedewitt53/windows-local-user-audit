# Windows Local User & Admin Audit
# Version 0.1

Write-Host "========================================"
Write-Host "    WINDOWS LOCAL USER & ADMIN AUDIT    "
Write-Host "========================================"
Write-Host ""

$LocalUsers = Get-LocalUser

Write-Host "Local Users"
Write-Host "----------------------------------------"

foreach ($User in $LocalUsers) {
    Write-Host "Name: $($User.Name)"
    Write-Host "Enabled: $($User.Enabled)"

if ($User.Enabled -eq $true) {
    Write-Host "Account Status: ENABLED"
}

else {
    Write-Host "Account Status: DISABLED"
    Write-Host ""
}

}

$LocalAdmins = Get-LocalGroupMember -Group "Administrators"

Write-Host ""
Write-Host "Local Administrators"
Write-Host "----------------------------------------"

foreach ($Admin in $LocalAdmins) {
    Write-Host "Name: $($Admin.Name)"
    Write-Host "Object Class: $($Admin.ObjectClass)"
    Write-Host ""
}