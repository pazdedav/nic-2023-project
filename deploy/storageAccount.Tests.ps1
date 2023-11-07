<#
.SYNOPSIS
    Deployment validation Pester (BenchPress) tests.
.DESCRIPTION
    This test plan validates all important properties of Storage Account.
.NOTES
    The tests can be run locally in VS Code (extension for Pester is available) or in a workflow.
.EXAMPLE
    Invoke-Pester -Output Detailed deploy/storageAccount.Tests.ps1
#>

[CmdletBinding()]
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
)

BeforeAll {
    Import-Module BenchPress.Azure -Force

    $Script:noStgName = 'noteststg'

}

Describe 'Verify Storage Account Exists' {
    It "Should contain a Storage Account named $StorageAccountName - Confirm-AzBPResource" {
        # arrange
        $params = @{
            ResourceType = "storageAccounts"
            ResourceName = $StorageAccountName
        }

        # act and assert
        Confirm-AzBPResource @params | Should -BeSuccessful
    }


    It "Should contain a Storage Account named $StorageAccountName - Confirm-AzBPResource" {
        # arrange
        $params = @{
            ResourceType  = "storageAccounts"
            ResourceName  = $StorageAccountName
            PropertyKey   = 'Location'
            PropertyValue = $Location
        }

        # act and assert
        Confirm-AzBPResource @params | Should -BeSuccessful
    }

    It "Should contain a Storage Account named $StorageAccountName" {
        Confirm-AzBPStorageAccount -Name $StorageAccountName -ResourceGroupName $ResourceGroupName | Should -BeSuccessful
    }

    It "Should not contain a Storage Account named $noStgName" {
        # The '-ErrorAction SilentlyContinue' command suppresses all errors.
        # In this test, it will suppress the error message when a resource cannot be found.
        # Remove this field to see all errors.
        Confirm-AzBPStorageAccount -Name $noStgName -ResourceGroupName $ResourceGroupName -ErrorAction SilentlyContinue | Should -Not -BeSuccessful
    }

    It "Should contain a Storage Account named $StorageAccountName in $Location" {
        Confirm-AzBPStorageAccount -Name $StorageAccountName -ResourceGroupName $ResourceGroupName | Should -BeInLocation $Location
    }
}

AfterAll {
    Get-Module Az.InfrastructureTesting | Remove-Module
    Get-Module BenchPress.Azure | Remove-Module
}