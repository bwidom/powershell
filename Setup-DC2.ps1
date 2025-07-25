# ----- Edit these Variables for your own Use Case ----- #
$PASSWORD_FOR_USERS   = "Password1"
$USER_FIRST_LAST_LIST = (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/bwidom/powershell/refs/heads/main/names.txt" -UseBasicParsing).Content.Trim().split("`n")
# ------------------------------------------------------ #

$password = ConvertTo-SecureString $PASSWORD_FOR_USERS -AsPlainText -Force
#New-ADOrganizationalUnit -Name _USERS -ProtectedFromAccidentalDeletion $false
$i = 0
foreach ($n in $USER_FIRST_LAST_LIST) {
    $i++
    $first = $n.Split(" ")[0].ToLower()
    $last = $n.Split(" ")[1].ToLower()
    $username = "$($first.Substring(0,1))$($last)".ToLower()
    Write-Host "Creating user: $($username)" -BackgroundColor Black -ForegroundColor Cyan
    
    New-AdUser -AccountPassword $password `
               -GivenName $first `
               -Surname $last `
               -DisplayName $username `
               -EmailAddress "$first.$last@mycompany.com" `
               -Name $username `
               -EmployeeID $i `
               -Enabled $true
               #-Path "ou=_USERS,$(([ADSI]`"").distinguishedName)" `
               
}

Add-ADGroupMember -Identity 'Remote Desktop Users' -Members $(Get-ADUser -Filter *)

#Install Winget
$progressPreference = 'silentlyContinue'
Write-Host "Installing WinGet PowerShell module from PSGallery..."
Install-PackageProvider -Name NuGet -Force | Out-Null
Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery | Out-Null
Write-Host "Using Repair-WinGetPackageManager cmdlet to bootstrap WinGet..."
Repair-WinGetPackageManager -AllUsers -Latest
Repair-WinGetPackageManager -AllUsers -Latest
Write-Host "Done."

#Install git
winget install --id Git.Git -e --source winget

git clone https://github.com/bwidom/helpdesk-tool.git

