# CKAN Docker

*CKAN running in docker with extensions*

## How to run
1. run `docker-compose up`

## To create an admin and organization
1. open a command line on the ckan container `docker exec -it ckan /bin/bash`
2. create and admin `paster --plugin=ckan sysadmin add admin -c /etc/ckan/default/default.ini`
3. log in to ckan `localhost:5000/ckan-admin`
4. create a new organization
 
