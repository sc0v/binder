#might need to worry about .psqlrc files and accessing the psql command with psql vs psql -h locahost
psql << EOF

--echo 'drop database'
DROP DATABASE devrv;
DROP DATABASE jenkins;
DROP DATABASE boauser;
DROP DATABASE boatest;
DROP DATABASE boadev;
DROP DATABASE boastage;
DROP DATABASE boaprod;

--echo 'Init PSQL Users'
DROP USER devsrv;
CREATE USER devsrv WITH PASSWORD '1234';
ALTER USER devsrv WITH PASSWORD '1234';
ALTER USER devsrv WITH SUPERUSER;

DROP USER jenkins;
CREATE USER jenkins WITH PASSWORD '1234';
ALTER USER jenkins WITH PASSWORD '1234';
ALTER USER jenkins WITH SUPERUSER;
 
DROP USER boauser;
CREATE USER boauser WITH PASSWORD 'Prof_H_No_Sn00p1ng';
ALTER USER boauser WITH PASSWORD 'Prof_H_No_Sn00p1ng';
ALTER USER boauser WITH SUPERUSER;

--echo 'User DBs'
CREATE DATABASE jenkins OWNER jenkins;
CREATE DATABASE devsrv OWNER devsrv;
CREATE DATABASE boauser OWNER boauser;

--echo 'Boa App DBs'
CREATE DATABASE boatest OWNER boauser;
CREATE DATABASE boadev OWNER boauser;
CREATE DATABASE boastage OWNER boauser;
CREATE DATABASE boaprod OWNER boauser;
 
EOF