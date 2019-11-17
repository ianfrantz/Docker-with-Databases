#Docker Pull SQL Server Image
docker pull mcr.microsoft.com/mssql/server
#Sql Server cmd Tools
docker pull mcr.microsoft.com/mssql-tools


$wd = Get-Location
#Set-up the Container:
docker run `
--name MSSQL-Latest `
-p 1433:1433 `
-e "ACCEPT_EULA=Y" `
-e "SA_PASSWORD=F00B4rB4z!" `
-v $wd/DatabaseBackups:/src `
-d mcr.microsoft.com/mssql/server:latest


#-----
#Code below doesn't work but one day might. For now just backup the database in SQL Server.


# docker exec MSSQL-Latest /opt/mssql-tools/bin/sqlcmd `
# -S localhost `
# -U "SA" `
# -P "SA_PASSWORD=F00B4rB4z!" 

# -Q "BACKUP DATABASE [Production-Snapshot] TO DISK = N'/var/opt/mssql/backup/Production-Snapshot.bak' WITH NOFORMAT, NOINIT, NAME = 'Production-Snapshot-full', SKIP, NOREWIND, NOUNLOAD, STATS = 10"


# docker exec MSSQL-Latest psql -U postgres -c "CREATE DATABASE adventureworks"
# docker exec MSSQL-Latest pg_restore -v -U SA -d adventureworks ./src/adventureworks/adventureworks.sql

#---Code Stops Here---
#The following pieces are an attempt to get the PowerShell dbatools module running. 
#---This code will pass all validations but not work. I'm hoping that in time this will eventually be supported in Docker.

# #Install dbatools
# Install-Module -Name dbatools 

# #Set-up credentials in xml document
# $CredentialPath = 'C:\Docker\SQL\credentials.xml'
# Get-Credential | Export-Clixml -Path $CredentialPath
# $cred = Import-Clixml $CredentialPath 

# #Connect to local MS SQL Server 2019
# help New-DbaCmConnection -Examples
# #$cred = Get-Credential 
# New-DbaCmConnection -ComputerName localhost -Credential $cred -CimWinRMOptions $options -DisableBadCredentialCache -OverrideExplicitCredential

# #Look at connection cache and run a test
# Get-DbaCmConnection
# Test-DbaCmConnection -ComputerName localhost -Force

# Get-DbaCredential -SqlInstance localhost

# #Get Logs
# Get-DbatoolsLog



# #Create a new connection object for remote computer management(Cm)
# New-DbaCmConnection -ComputerName localhost -UseWindowsCredentials

# New-DbaConnectionString -SqlInstance localhost -TrustServerCertificate 'TRUE'

# param( 
    
#     $SqlServer = "localhost", 
#     $SqlServerPort = 1433, 
#     $SqlQueryTimeout = 30, 
#     $Database = "admin", 
#     $SqlCredentialAsset = "SA",
#     $SqlQuery = "SELECT TOP [1] * FROM Example"
# )

# $conparams = @{ 
#     SqlServer = 'localhost' 
#     SqlServerPort = 1433
#     SqlQueryTimeout = 30 
#     Database = 'admin'
#     SqlCredentialAsset = 'SA'
#     SqlQuery = 'SELECT TOP [1] * FROM Example'
# }