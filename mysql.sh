#!/usr/bin/bash

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

ip_mysql=10.73.98.115
us_mysql=chalista
pw_mysql=chalista2005

name=$(cat table.txt | awk -v a=$1 -v b=$2 'NR==a,NR==b')
folder=/home/dsp_new/xpt/

echo $1 " " $2 >> log_dump.txt

for var in $name
do
// put code here
done
