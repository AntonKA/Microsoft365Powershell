
# Get your installed modules first 
Get-InstalledModule 

# Define the set of modules installed and updated from the PowerShell Gallery that we want to maintain
$O365Modules = @("MicrosoftTeams", "AzureADPreview", "ExchangeOnlineManagement", "AzureADPreview", "PowerShellGet", "AzureAD")

# Check and update all modules to make sure that we're at the latest version
ForEach ($Module in $O365Modules) {
   Write-Host "Checking and updating module" $Module
   Update-Module $Module -Force -Scope AllUsers }




# For any additional info please contact anton.amosh@outlook.com