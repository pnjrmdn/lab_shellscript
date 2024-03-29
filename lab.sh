#!/usr/bin/bash 

###------------------------------------------------------------------------------------------------------------------------------
### nginx hosting web with fpm different
    location /app/ {
        alias /home/dir/app/;
        index index.php;
        location ~ \.php$ {
            include snippets/fastcgi-php.conf;
            fastcgi_param SCRIPT_FILENAME $request_filename;
            fastcgi_pass unix:/var/run/php/php7.3-fpm.sock;
        }
    }

###------------------------------------------------------------------------------------------------------------------------------
#send file server to server 
scp /home/dir/db_backup/{file.sql} {username_ssh}@{ip_host}:/home/dir/db_backup

###------------------------------------------------------------------------------------------------------------------------------
### untuk dump DB mysql .sql

name=$(cat table.txt | awk -v a=$1 -v b=$2 'NR==a,NR==b')
folder_dump=/home/dir/database

echo $1 " " $2 >> log_dump.txt

for var in $name
do
mysqldump --verbose --lock-tables=false \
--max-allowed-packet=512M --quick --force -P 3306 -h {ip_host} -u {username} \
-p{password} {database} $var 2> "$folder_dump"log_$var.txt > "$folder_dump"$var.sql
echo $var
done

### untuk import DB mysql .sql
name=$(cat table.txt | awk -v a=$1 -v b=$2 'NR==a,NR==b')

echo $1 " " $2 >> log_number_import.txt

for var in $name
do
mysql -u {username} -p{password} {database}< $var.sql
echo $var >> log_import.txt
done

### untuk dump --- Table DB mysql .sql
folder_dump=/home/db_backup/
var=$1

mysqldump --verbose --lock-tables=false \
--max-allowed-packet=512M --quick --force -P 3306 -h {ip_host} -u {username} \
-p{password} $var 2> "$folder_dump"log_"$var"$2.txt > "$folder_dump"$var.sql


### untuk import DB mysql .sql
##remote
mysql -u {username} -h {ip_host} -p{password} -f -D db_name < db_name.sql

###local
var=$1
mysql -u {username} -p $var < $var.sql

##looping
name=$(cat table.txt | awk -v a=$1 -v b=$2 'NR==a,NR==b')
folder=/home/db_backup/name_db/log/
folder_dump=/home/db_backup/name_db/

echo $1 " " $2 >> log_number_import.txt

for var in $name
do
mysql -u {username} -p{password}d name_db < $var.sql
echo $var >> log_import.txt
done

###------------------------------------------------------------------------------------------------------------------------------

### untuk load data dari csv ke DB mysql
folder="/home/"$1

ip_mysql={ip_host}
us_mysql={username}
pw_mysql={password}

echo "load data local infile '"$folder"' into table $2 fields terminated by '|' lines terminated by '\n'" | 
mysql --local-infile=1 -h$ip_mysql -u$us_mysql -p$pw_mysql {database}

### untuk export data dari DB mysql ke csv 

com="SELECT * FROM $1
WHERE rat IN ('2G', '3G') AND
period = '20230202' AND `payload` > 10240"

mysql -u $us_mysqs -p$ip_mysql -h $us_ysql {database} -e "$com" | sed 's/\t/","/g;s/^/"/;s/$/"/;s/\n//g' > $folder/$2.csv
echo $com


### looping dengan file .txt teks

ip_mysql={ip_host}
us_mysql={username}
pw_mysql={password}

name=$(cat table.txt | awk -v a=$1 -v b=$2 'NR==a,NR==b')
folder=/home/dir/

echo $1 " " $2 >> log_dump.txt

for var in $name
do
// put code here
done

###------------------------------------------------------------------------------------------------------------------------------

### resync database 1 dgn database 2

expect << eof
 set timeout 1200
 spawn rsync -avz -e ssh root@{ip_server}:/var/lib/mysql/name_db /var/lib/mysql
 expect "*password*"
 send "{password}\n"
 expect "*#*"
 send "exit\n"
eof