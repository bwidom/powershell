Set-TimeZone -Id "Eastern Standard Time"
#Make server discoverable on network
netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes
#Install Active Directory
Add-WindowsFeature AD-Domain-Services -IncludeManagementTools
#Setup Domain Forest
Install-ADDSForest -DomainName 'MyDomain.com' -SafeModeAdministratorPassword $(ConvertTo-SecureString 'Adminpassword1' -AsPlainText -Force) -Confirm:$false
