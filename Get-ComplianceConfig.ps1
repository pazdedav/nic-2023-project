
# Step 1 - psrule.assignment.json
Export-AzPolicyResources -DefinitionsRootFolder ./ -Mode psrule -OutputFolder ./

# Step 2 - definitions-export-0f83848d8d.Rule.jsonc
Export-AzPolicyAssignmentRuleData -AssignmentFile ./psrule.assignment.json -OutputPath ./ps-rule

# Step 3 - test
Assert-PSRule -InputPath ./ -Module "PSRule.Rules.Azure" -Format File

# Optional step - export to CSV
Assert-PSRule -InputPath ./ -Module "PSRule.Rules.Azure" -Format File -OutputFormat Csv -OutputPath exceptions.csv

