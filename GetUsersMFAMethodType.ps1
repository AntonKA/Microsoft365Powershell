#Get users from specific OU

$a = Get-ADuser -Filter *  -searchbase "OU=Users,OU=Moscow,OU=Sites,DC=contoso,DC=com" -Properties * | Select-Object sAMAccountName

$a | Export-Csv -Path C:\Users\antonadmin\Desktop\MoscowUsers.csv -NoTypeInformation

Connect-MsolService 

    #Get all accounts for filtering
    $MSOLUsers = Import-Csv -Path C:\Users\ataa\Desktop\DEL\MFAbom.csv #--> you have to use a kind of CSV here…

    #Process results into a PSCustom Object with relevant info
   $a=ForEach ($User in $MSOLUsers) {

        #Get the UserPrinicipalname for precise object Filtering
        $UPN = $User.UPN

        #Filter Msol Users using their UPN object data
        $UserObject = get-msoluser -MaxResults 9999 -SearchString $UPN | Select-Object DisplayName, UserprincipalName, islicensed
        $UserObject2 = get-msoluser -MaxResults 9999 -SearchString $UPN | Select-Object -Expand StrongAuthenticationRequirements
        $UserObject3 = get-msoluser -MaxResults 9999 -SearchString $UPN | Select-Object -Expand StrongAuthenticationMethods | Where-Object { $_.IsDefault -eq "True" }

        <#Pull Administrator Statuses
        $ca = Get-MsolRole -RoleName "Company Administrator"
        $CompanyAdministrator = Get-MsolRoleMember -RoleObjectId $ca.objectid | Where-Object { $_.EmailAddress -eq "$upn" }
        if ($null -ne $CompanyAdministrator) {
            $CaResult = $True
        }
        else {
            $CaResult = $False
        }

        $Ba = Get-MsolRole -RoleName "Company Administrator"
        $BillingAdministrator = Get-MsolRoleMember -RoleObjectId $ba.objectid | Where-Object { $_.EmailAddress -eq "$upn" }
        if ($null -ne $BillingAdministrator) {
            $BiResult = $True
        }
        else {
            $BiResult = $False
        }#>


        #Output Custom Object Info
        [pscustomobject]@{
            DisplayName       = $UserObject.DisplayName
            UserprincipalName = $UserObject.UserprincipalName
            IsLicensed        = $UserObject.islicensed
            MFAState          = $UserObject2.State
            MFAMethodDefault  = $UserObject3.Methodtype
            #IsCompanyAdministrator = $CaResult
            #IsBillingAdministrator = $BiResult
        }
    } 


    $a  | Export-Csv -Path  C:\Users\anton\Desktop\Moscow.csv -NoTypeInformation
