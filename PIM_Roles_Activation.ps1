# Install required modules (only needed first time).

Install-Module -name dctoolbox -force 

Install-Module -name AzureADPreview -force -AllowClobber

Install-Package msal.ps -AcceptLicense -Force


# Enable on of your Azure AD PIM roles 

Enable-DCAzureADPIMRole


# Enable Multiple Azure AD PIM Roles 

Enable-DCAzureADPIMRole -RolesToActivate 'Teams Administrator'



# Fully Automate Azure AD PIM role activation.

Enable-DCAzureADPIMRole -RolesToActivate 'Teams Administrator','Authentication Administrator','Exchange Administrator','Directory Readers','User Administrator','Application Administrator' -UseMaxiumTimeAllowed -Reason "This role has been activated to perform some daily operational tasks"


# For more info please contact anton.amosh@outlook.com