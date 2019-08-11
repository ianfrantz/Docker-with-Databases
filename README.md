# Goal: Scripted Docker deployments for the latest SQL Server and PostgreSQL database software.
* Subgoal: Optional database restores of Adventureworks or DVDRental.
* Noteable: Intermediate SQL Server code and Stress Testing available too.


# Set-up
* All files are in numerical order of execution. `1.*, 2.*, 3.* ect`
* Start by opening the VS Code PowerShell script for the respective Database Software.
 + Scripts begin with:
 `docker pull postgres:latest` or `docker pull mcr.microsoft.com/mssql/server`
 + Press F8 to run an individual line in PowerShell.
 + Use F1 to bring up user workspace settings if your paths need configured.
 + Disable your local Windows 10 Firewall if you have trouble.

# Docker Exec 
* `docker exec` to create PostgreSQL-Latest

Handy [psql commands](https://gpdb.docs.pivotal.io/gs/43/pdf/PSQLQuickRef.pdf)

  + To run the Docker container that contains Postgres, you can enter this from a command prompt:

    `$ docker exec -ti sql-pet_postgres9_1 bash`

  + To exit Docker enter:

    `# exit`

  + Inside Docker, you can enter the Postgres command-line utility psql by entering 

    `# psql -U postgres`

    Handy [psql commands](https://gpdb.docs.pivotal.io/gs/43/pdf/PSQLQuickRef.pdf) include:

    + `postgres=# \h`          # psql help
    + `postgres=# \dt`         # list Postgres tables
    + `postgres=# \c dbname`   # connect to databse dbname
    + `postgres=# \l`          # list Postgres databases
    + `postgres=# \conninfo`   # display information about current connection
    + `postgres=# \q`          # exit psql
