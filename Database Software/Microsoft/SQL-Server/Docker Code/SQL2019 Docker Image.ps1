#Docker Pull
docker pull mcr.microsoft.com/mssql/server

#Set-up the Container:
docker run `
--name MSSQL19 `
-p 1433:1433 `
-e "ACCEPT_EULA=Y" `
-e "SA_PASSWORD=F00B4rB4z!" `
-v C:\Docker\SQL:/sql `
-d mcr.microsoft.com/mssql/server:latest

#Install dbatools
Install-Module -Name dbatools 

#Set-up credentials in xml document
$CredentialPath = 'C:\Docker\SQL\credentials.xml'
Get-Credential | Export-Clixml -Path $CredentialPath
$cred = Import-Clixml $CredentialPath 

#Connect to local MS SQL Server 2019
help New-DbaCmConnection -Examples
#$cred = Get-Credential 
New-DbaCmConnection -ComputerName localhost -Credential $cred -CimWinRMOptions $options -DisableBadCredentialCache -OverrideExplicitCredential

#Look at connection cache and run a test
Get-DbaCmConnection
Test-DbaCmConnection -ComputerName localhost -Force

Get-DbaCredential -SqlInstance localhost

#Get Logs
Get-DbatoolsLog



#Create a new connection object for remote computer management(Cm)
New-DbaCmConnection -ComputerName localhost -UseWindowsCredentials

New-DbaConnectionString -SqlInstance localhost -TrustServerCertificate 'TRUE'

param( 
    
    $SqlServer = "localhost", 
    $SqlServerPort = 1433, 
    $SqlQueryTimeout = 30, 
    $Database = "admin", 
    $SqlCredentialAsset = "SA",
    $SqlQuery = "SELECT TOP [1] * FROM Example"
)

$conparams = @{ 
    SqlServer = 'localhost' 
    SqlServerPort = 1433
    SqlQueryTimeout = 30 
    Database = 'admin'
    SqlCredentialAsset = 'SA'
    SqlQuery = 'SELECT TOP [1] * FROM Example'
}