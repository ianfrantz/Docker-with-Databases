#Start Ostress Parameters
$Arguments = @(
"-E", #Use Windows credential trust
"-S.", #Server
"-U""sa", #Username
"-P""F00B4rB4z!", #Password
"-d`"Admin`"", #Database
"-i`"..\SQL Code\Resource Governer\LoadGenPool1.sql`"", #Location of your query
"-n10", #How many simultaneous sessions should be established
"-r5", #How many iterations should be performed
"-q", #Quite mode doesn't return rows
"-o`"..\Ostress Code\Ostress Logs`"") #Logging folder

#Set the path for Ostress.exe
$Command = "C:\Program Files\Microsoft Corporation\RMLUtils\ostress.exe"

#Start the Ostress process
Start-Process $Command -ArgumentList $Arguments