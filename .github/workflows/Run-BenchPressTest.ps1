<#
.SYNOPSIS
    A script to run a Pester test plan in a GitHub Action.
.DESCRIPTION
    A script that takes a few input parameters and executes a Pester test with BenchPress.
.NOTES

.LINK
    Specify a URI to a help page, this will show when Get-Help -Online is used.
.EXAMPLE
    ./Run-BenchPressTest.ps1 -Verbose
    Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
#>

<# [CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [string]
    $StorageAccountName,

    [Parameter(Mandatory)]
    [string]
    $Location,

    [Parameter(Mandatory)]
    [string]
    $ResourceGroupName
) #>


Set-PSRepository psgallery -InstallationPolicy trusted
Install-Module -Name Pester -RequiredVersion 5.5.0 -Confirm:$false -Force -SkipPublisherCheck
Install-Module -Name BenchPress.Azure -RequiredVersion 0.2.1 -Confirm:$false -Force -SkipPublisherCheck
Import-Module Pester -Force
Import-Module BenchPress.Azure -Force
$configuration = [PesterConfiguration]::Default
$configuration.TestResult.Enabled = $true
$configuration.Output.Verbosity = 'Detailed'
$configuration.TestResult.OutputFormat = 'NUnitXml'
$configuration.TestResult.OutputPath = 'Test.xml'
$configuration.Output.CIFormat = 'GithubActions'
$container = New-PesterContainer -Path "./deploy/storageAccount.Tests.ps1" #-Data @{ StorageAccountName = $StorageAccountName; ResourceGroupName = $ResourceGroupName; Location = $Location }
$configuration.Run.Container = $container
$configuration.Run.PassThru = $true
$result = Invoke-Pester -Configuration $configuration
exit $result.FailedCount