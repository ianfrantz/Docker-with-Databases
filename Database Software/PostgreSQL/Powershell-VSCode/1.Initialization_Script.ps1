#Docker Pull
docker pull postgres

#Run under the Dockerfiles where YAML is
#docker-compose command reads 'docker-compose.yml'
docker-compose up -d

docker exec dockerfiles_postgres9_1 psql -U postgres -c "CREATE DATABASE dvdrental"

docker exec dockerfiles_postgres9_1 pg_restore -v -U postgres -d dvdrental ./src/dvdrental.tar

#Set-up the Container:
docker run `
--name PostgreSQL-DVDRental `
-p 1433:1433 `
-e "ACCEPT_EULA=Y" `
-e "SA_PASSWORD=postgres" `
-v ./:/sql `
-d postgres

#Bash on the Container
docker exec -ti sql-pet_postgres9_1 bash