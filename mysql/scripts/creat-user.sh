#!/bin/bash
# A shell script to add mysql database, username and password.
# -------------------------------------------------------------------------
_db="pretix"
_user="pretix"
_pass="pretix"

## Mysql root settings ##
_madminuser='root'
_madminpwd='root'


# make sure we get 3 args, else die
[[ $# -le 2 ]] && { echo "Usage: $0 'DB_Name' 'DB_USER' 'DB_PASSORD' "; exit 1; }

echo 'FLUSH PRIVILEGES;' > /tmp/sql

# create DB
query=" CREATE DATABASE ${_db} ;";
echo $query >> /tmp/sql

# grant permission
query=" GRANT ALL ON ${_db}.* TO ${_user} IDENTIFIED BY '${_pass}';";
echo $query >> /tmp/sql

 #check db and permission
query="SELECT Host, Db, User FROM mysql.db WHERE User='${_user}' and Db='${_db}';";
echo $query >> /tmp/sql

echo "Running: [sudo mysql -u${_madminuser} --password=\"${_madminpwd}\" < /tmp/sql]"
sudo mysql -u${_madminuser} --password="${_madminpwd}" < /tmp/sql
