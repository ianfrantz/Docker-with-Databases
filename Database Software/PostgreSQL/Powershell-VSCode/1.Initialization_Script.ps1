#Docker Pull
docker pull postgres:latest

#docker-compose command reads 'docker-compose.yml'
docker-compose up -d

#Steps to now restore dvdrental database on PostgreSQL-Latest container.
docker exec PostgreSQL-Latest psql -U postgres -c "CREATE DATABASE dvdrental"
docker exec PostgreSQL-Latest pg_restore -v -U postgres -d dvdrental ./src/dvdrental.tar

#----This is the end of the script----

#Alternative Container Set-up and troublehsooting:
# docker run `
# --name PostgreSQL-Latest `
# -p 1433:1433 `
# -e "ACCEPT_EULA=Y" `
# -e "SA_PASSWORD=postgres" `
# -v ./:/sql `
# -d postgres

# #Bash on the Container
# docker exec -ti PostgreSQL-Latest bash