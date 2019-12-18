#Docker Pull SQL Server Image
docker pull mcr.microsoft.com/mssql/server
#Sql Server cmd Tools
docker pull mcr.microsoft.com/mssql-tools


#-----Setup Docker-----

#NOTE: Relative paths is an open issue. $wd is used to get around the problem. You will need to set this to repo path: \Database\ Software\Microsoft\Powershell-VSCode\
$wd = Get-Location
#Set-up the Container:
docker run `
--name MSSQL-Latest `
-p 1433:1433 `
-e "ACCEPT_EULA=Y" `
-e "SA_PASSWORD=F00B4rB4z!" `
-v $wd/DatabaseBackups:/src `
