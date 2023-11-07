# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# Note:
# This is run during container creation.

# Install PowerShell dependencies
$ProgressPreference = [System.Management.Automation.ActionPreference]::SilentlyContinue;
if ($Null -eq (Get-PackageProvider -Name NuGet -ErrorAction Ignore)) {
    Install-PackageProvider -Name NuGet -Force -Scope CurrentUser;
}
if ($Null -eq (Get-InstalledModule -Name PowerShellGet -MinimumVersion 2.2.5 -ErrorAction Ignore)) {
    Install-Module -Name PowerShellGet -MinimumVersion 2.2.5 -Scope CurrentUser -Force -AllowClobber;
}
if ($Null -eq (Get-InstalledModule -Name PSRule -MinimumVersion 2.9.0 -ErrorAction Ignore)) {
    Install-Module -Name PSRule.Rules.Azure -MinimumVersion 2.9.0 -Scope CurrentUser -Force;
}
if ($Null -eq (Get-InstalledModule -Name PSRule.Rules.Azure -MinimumVersion 1.30.3 -ErrorAction Ignore)) {
    Install-Module -Name PSRule.Rules.Azure -MinimumVersion 1.30.3 -Scope CurrentUser -Force;
}
if ($Null -eq (Get-InstalledModule -Name Pester -MinimumVersion 5.5.0 -ErrorAction Ignore)) {
    Install-Module -Name Pester -MinimumVersion 5.5.0 -Scope CurrentUser -Force;
}
if ($Null -eq (Get-InstalledModule -Name EnterprisePolicyAsCode -MinimumVersion 8.4.4 -ErrorAction Ignore)) {
    Install-Module -Name EnterprisePolicyAsCode -MinimumVersion 8.4.4 -Scope CurrentUser -Force;
}
if ($Null -eq (Get-InstalledModule -Name BenchPress.Azure -MinimumVersion 0.2.2 -ErrorAction Ignore)) {
    Install-Module -Name BenchPress.Azure -MinimumVersion 0.2.2 -Scope CurrentUser -Force;
}
if ($Null -eq (Get-InstalledModule -Name Az -MinimumVersion 10.4.1 -ErrorAction Ignore)) {
    Install-Module -Name Az -MinimumVersion 10.4.1 -Scope CurrentUser -Force;
}