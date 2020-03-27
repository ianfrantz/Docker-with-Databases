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

#MANUAL TASK: Restore Wide World Importers after moving it into $wd. (File too big for github)
Restore-DbaDatabase -SqlInstance localhost:1433 -SqlCredential $cred -Path /src/WideWorldImporters/WideWorldImporters-Full.bak


#-----BACKUP-----
#Backup Adventureworks2017 (Default Path if not specified: /var/opt/mssql/data)
Backup-DbaDatabase -SqlInstance localhost:1433 -SqlCredential $cred -Path /src -Database AdventureWorks2017, Sales.Customer 


#-----Troubleshooting-----
#Get Logs from Dba Tools
Get-DbatoolsLog