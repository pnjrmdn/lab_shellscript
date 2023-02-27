#!/usr/bin/bash

### untuk dump DB mysql .sql
folder_dump=/home/dbbackup222/
var=$1

mysqldump --verbose --lock-tables=false \
--max-allowed-packet=512M --quick --force -P 3306 -h {ip_host} -u {username} \
-p{password} $var 2> "$folder_dump"log_"$var"$2.txt > "$folder_dump"$var.sql

### untuk dump --- Table DB mysql .sql
folder_dump=/home/dbbackup222/
var=$1

mysqldump --verbose --lock-tables=false \
--max-allowed-packet=512M --quick --force -P 3306 -h {ip_host} -u {username} \
-p{password} $var 2> "$folder_dump"log_"$var"$2.txt > "$folder_dump"$var.sql


### untuk import DB mysql .sql
##remote
mysql -u vmborneo -h {ip_host} -p{password} -f -D area < area.sql

###local
var=$1
mysql -u chalista -pchalista2005 $var < $var.sql

##looping
name=$(cat table.txt | awk -v a=$1 -v b=$2 'NR==a,NR==b')
folder=/home/dbbackup222/hadoop/log/
folder_dump=/home/dbbackup222/hadoop/

echo $1 " " $2 >> log_number_import.txt

for var in $name
do
mysql -u {username} -p{password}d hadoop < $var.sql
echo $var >> log_import.txt
done

###------------------------------------------------------------------------------------------------------------------------------

### untuk load data dari csv ke DB mysql
folder="/home/dsp_new/"$1

ip_mysql={ip_host}
us_mysql={username}
pw_mysql={password}

echo "load data local infile '"$folder"' into table $2 fields terminated by '|' lines terminated by '\n'" | 
mysql --local-infile=1 -h$ip_mysql -u$us_mysql -p$pw_mysql dsp_new

### untuk export data dari DB mysql ke csv 

com="SELECT * FROM $1
WHERE rat IN ('2G', '3G') AND
period = '20230202' AND `payload` > 10240"

mysql -u $us_mysqs -p$ip_mysql -h $mus_ysql dsp_new -e "$com" | sed 's/\t/","/g;s/^/"/;s/$/"/;s/\n//g' > $folder/$2.csv
echo $com


### looping dengan file .txt teks

ip_mysql={ip_host}
us_mysql={username}
pw_mysql={password}

name=$(cat table.txt | awk -v a=$1 -v b=$2 'NR==a,NR==b')
folder=/home/dsp_new/xpt/

echo $1 " " $2 >> log_dump.txt

for var in $name
do
// put code here
done

###------------------------------------------------------------------------------------------------------------------------------

### resync database 1 dgn database 2

expect << eof
 set timeout 1200
 spawn rsync -avz -e ssh root@{ip_server}:/var/lib/mysql/hadoop /var/lib/mysql
 expect "*password*"
 send "{password}\n"
 expect "*#*"
 send "exit\n"
eof