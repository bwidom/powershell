Set-TimeZone -Id "Eastern Standard Time"
#Make server discoverable on network
netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes

#Install Winget
$progressPreference = 'silentlyContinue'
Write-Host "Installing WinGet PowerShell module from PSGallery..."
Install-PackageProvider -Name NuGet -Force | Out-Null
Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery | Out-Null
Write-Host "Using Repair-WinGetPackageManager cmdlet to bootstrap WinGet..."
Repair-WinGetPackageManager -AllUsers
Write-Host "Done."

#Install git
winget install --id Git.Git -e --source winget

#Install Active Directory
Add-WindowsFeature AD-Domain-Services -IncludeManagementTools
#Setup Domain Forest
Install-ADDSForest -DomainName 'MyDomain.com' -SafeModeAdministratorPassword $(ConvertTo-SecureString 'Adminpassword1' -AsPlainText -Force) -Confirm:$false
