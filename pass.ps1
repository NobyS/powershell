Install-Module Microsoft.PowerShell.SecretManagement, Microsoft.PowerShell.SecretStore


#Getting Started with SecretStore
#While this example is being shown with SecretStore, the example can be followed with any number of extensions vaults.

#First Register the vault, the name parameter is a friendly name and can be anything you choose 

Register-SecretVault -Name SecretStore -ModuleName Microsoft.PowerShell.SecretStore -DefaultVault

#Now you can create a secret, you will also need to provide a password for the SecretStore vault 

Set-Secret -Name VMSecret -Secret "Mein Paswort"

Get-Secret -Name VMSecret -AsPlainText