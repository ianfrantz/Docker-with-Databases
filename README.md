# This project is open for collaboration and contains the following at various levels: 
* Beginner: 
  + PowerShell Docker deployments for MSSQL-Latest and PostgreSQL-Latest database software.
  + Docker run and compose examples
* Intermediate: 
  + [dbatools](https://dbatools.io/) Restore and `Backup-DbaDatabase`
  + Power BI 
* Advanced: 
  + T-SQL Code
  + SQL Server Stress Testing

# Main Databases in Project:
* SQL Server:
  + AdventureWorks2017
  + AdventureWorksDW2017
* PostgreSQL:
  + adventureworks
  + dvdrental

# Set-up
* All files are in numerical order of execution. `1.*, 2.*, 3.* ect`
* Start by opening the VS Code PowerShell script for the respective Database Software.
 + Scripts begin with:
 `docker pull postgres:latest` or `docker pull mcr.microsoft.com/mssql/server`
 + Press F8 to run an individual line in PowerShell.
 + Use F1 to bring up user workspace settings if your paths need configured.
 + Disable your local Windows 10 Firewall if you have trouble.

# Launch
* ContainerNames: 
+ `PostgreSQL-Latest`
+ `MSSQL-Latest`

* Type `docker start [ContainerName]` 
* Stop with `docker stop [ContainerName]`

# Connect
* PostgreSQL: localhost:1433
* SQL Server: localhost:1433

### ------
# Troubleshooting
Handy [psql commands](https://gpdb.docs.pivotal.io/gs/43/pdf/PSQLQuickRef.pdf)

  + To run the Docker container that contains Postgres, you can enter this from a command prompt:

    `$ docker exec -ti [ContainerName] bash`

  + Inside Docker, you can enter the Postgres command-line utility psql by entering: 

    `# psql -U postgres`

  + To exit Docker enter:

    `# exit`
    
  + To remove all containers:
  
  `docker rm $(docker ps -a -q)`
  
  
+ Other:
    Handy [psql commands](https://gpdb.docs.pivotal.io/gs/43/pdf/PSQLQuickRef.pdf) include:

    + `postgres=# \h`          # psql help
    + `postgres=# \dt`         # list Postgres tables
    + `postgres=# \c dbname`   # connect to databse dbname
    + `postgres=# \l`          # list Postgres databases
    + `postgres=# \conninfo`   # display information about current connection
    + `postgres=# \q`          # exit psql
