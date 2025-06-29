Set-TimeZone -Id "Eastern Standard Time"
Add-WindowsFeature AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName 'MyDomain.com' -SafeModeAdministratorPassword $(ConvertTo-SecureString 'Adminpassword1' -AsPlainText -Force) -Confirm:$false
