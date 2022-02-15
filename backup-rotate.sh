#!/bin/bash


backup_list=$(ls /home/achern/Yandex.Disk/ | grep backup)
days=5
#echo $backup_list

month=$(date +"%m")

ed="date +\"%Y-%m-%d\" -d '-"$days" day'"
echo $ed
eval $ed
expire_date=`eval $ed`".tar.gz"
echo "expire_date: $expire_date"

echo "Удаляем бекапы, старше $(date +"%d.%m.%Y" -d '-13 day') expire_date: $expire_date"

for file in $backup_list; do
    backup_date=$(echo $file | awk -F"_" '{print $2}')
    #echo "backup_2021-$backup_date-$month.tar.gz"
    echo $file
    echo "  expire_date: $expire_date backup_date: $backup_date"
    if [[ $backup_date < $expire_date ]]
        then
            echo "    удаляем /home/achern/Yandex.Disk/"$file
            rm -f /home/achern/Yandex.Disk/$file
    fi
done

