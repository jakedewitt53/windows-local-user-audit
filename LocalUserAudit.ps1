# Windows Local User & Admin Audit
# Version 0.1

Write-Host "========================================"
Write-Host "    WINDOWS LOCAL USER & ADMIN AUDIT    "
Write-Host "========================================"
Write-Host ""

$LocalUsers = Get-LocalUser
$EnableUsers = $LocalUsers | Where-Object { $_.Enabled -eq $true }
$LocalAdmins = Get-LocalGroupMember -Group "Administrators"
$EnabledUserCount = $LocalAdmins.Count
$AdminCount = $LocalAdmins.Count
$UserAuditResults = foreach ($User in $LocalUsers) {
    [PSCustomObject]@{
        Name        = $User.Name
        Enabled     = $User.Enabled
        Description = $User.Description
    }
}

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

Write-Host ""
Write-Host "Audit Summary"
Write-Host "----------------------------------------"

Write-Host "Enabled Local Accounts: $EnabledUserCount"
Write-Host "Local Administrator Entries: $AdminCount"

if($AdminCount -gt 3) {
    Write-Host "Audit Status: REVIEW - Multiple local administrator entries detected."
}
else {
    Write-Host "Audit Status: OK - Administrator count is within expected range."
}

$UserAuditResults | Export-Csv -Path ".\LocalUserAudit.csv" -NoTypeInformation

Write-Host ""
Write-Host "CSV Export: LocalUserAudit.csv created successfully."