#-----Restore Database Backups with dbatools-----
#Install dbatools (Command List: https://dbatools.io/commands/)
Install-Module -Name dbatools

# Set the credentials for the SA Account. Connect to local MS SQL Server 2019
$User = "sa"
$PWord = ConvertTo-SecureString -String "F00B4rB4z!" -AsPlainText -Force
$Cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

#-----RESTORATION-----
#Restore Adventureworks2017
Restore-DbaDatabase -SqlInstance localhost:1433 -SqlCredential $cred -Path /src/adventureworks/AdventureWorks2017.bak

#Restore Adventureworks Data Warehouse
Restore-DbaDatabase -SqlInstance localhost:1433 -SqlCredential $cred -Path /src/adventureworks/AdventureWorksDW2017.bak

#Download Wide World Importers V1.0 BAK file from Microsoft
$wideworldimporters = "https://github.com/microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Full.bak"
cd $PSScriptRoot
$output = Get-Location
Invoke-WebRequest -Uri $wideworldimporters -OutFile $output\DatabaseBackups\WideWorldImporters\WideWorldImporters-Full.bak
#Restore Wide World Importers
Restore-DbaDatabase -SqlInstance localhost:1433 -SqlCredential $cred -Path /src/WideWorldImporters/WideWorldImporters-Full.bak


#-----BACKUP-----
#Backup Adventureworks2017 (Default Path if not specified: /var/opt/mssql/data)
Backup-DbaDatabase -SqlInstance localhost:1433 -SqlCredential $cred -Path /src -Database AdventureWorks2017, Sales.Customer 

#-----Troubleshooting-----
#Get Logs from Dba Tools
Get-DbatoolsLog