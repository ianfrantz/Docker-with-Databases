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

#-----Restore Database Backups with dbatools-----
#Install dbatools
Install-Module -Name dbatools 

# Set the credentials for the SA Account. Connect to local MS SQL Server 2019
$cred = Get-Credential
Restore-DbaDatabase -SqlInstance localhost:1433 -SqlCredential $cred -Path /src/adventureworks/AdventureWorks2017.bak

#Get Logs
Get-DbatoolsLog

#-----Attempted Backup using mssql-tools-----
#Code below doesn't work but one day might. F

# docker exec MSSQL-Latest /opt/mssql-tools/bin/sqlcmd `
# -S localhost `
# -U "SA" `
# -P "SA_PASSWORD=F00B4rB4z!" 

# -Q "BACKUP DATABASE [Production-Snapshot] TO DISK = N'/var/opt/mssql/backup/Production-Snapshot.bak' WITH NOFORMAT, NOINIT, NAME = 'Production-Snapshot-full', SKIP, NOREWIND, NOUNLOAD, STATS = 10"

#-----Below code is just interesting stuff I want to keep-----

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

# #Set-up credentials in xml document
# $CredentialPath = 'C:\Docker\SQL\credentials.xml'
# Get-Credential | Export-Clixml -Path $CredentialPath
# $cred = Import-Clixml $CredentialPath 

#New-DbaConnectionString -SqlInstance localhost:1433 -TrustServerCertificate 'TRUE'