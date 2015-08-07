Copy-Item "C:\vagrant\ISO\SQLServer2014SP1-FullSlipstream-x64-ENU.iso" "c:\tmp\SQLServer2014SP1-FullSlipstream-x64-ENU.iso"
Copy-Item  "C:\vagrant\SQLServer\ConfigurationFile.ini" "C:\tmp\ConfigurationFile.ini" 

$Iso = "c:\tmp\SQLServer2014SP1-FullSlipstream-x64-ENU.iso"
$ConfigurationFile = "C:\tmp\ConfigurationFile.ini" 

# Create the dummy directories, until we have proper disks
New-Item c:\disk_I -type directory
New-Item c:\disk_F -type directory
New-Item c:\disk_G -type directory

#Import DISM Module
Import-Module -Name DISM -Verbose:$False

# Mount the OS ISO image onto the local machine
Mount-DiskImage -ImagePath $Iso 

# Get the Volume the Image is mounted to
$iSOImage = Get-DiskImage -ImagePath $Iso | Get-Volume

# And get the drive Letter of the drive where the image is mounted
# add the drive letter separator (:)
$iSODrive = "$([string]$iSOImage.DriveLetter):"

#Run SQL Server Installer using the config file

$cmd = "$iSODrive\Setup.exe /Q /IAcceptSQLServerLicenseTerms /SQLSVCPASSWORD=M0t0r0l4 /AGTSVCPASSWORD=M0t0r0l4 /SAPWD=M0t0r0l4 /ConfigurationFile=$ConfigurationFile "

Invoke-Expression $cmd 
