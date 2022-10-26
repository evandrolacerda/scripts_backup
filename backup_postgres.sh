#!/bin/bash
NOW=$(date +"%m-%d-%Y-%H%M%S")
for i in $(psql -q -A -t -c "SELECT datname FROM pg_database where datname not in('postgres', 'template0', 'template1')" -U postgres)
do
	pg_dump  $i -Z 5 -U postgres > /home/$USER/backup/$i-$NOW.gz
done

#delete files older than 7 days
find /home/$USER/backup/ -type f -mtime +7 -name '*.gz' -execdir rm -- '{}' \;
