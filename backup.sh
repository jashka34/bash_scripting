#!/bin/bash
otkuda="/home/achern/yodo/bash_scripting/bkp/"
kuda="/home/achern/yodo/bash_scripting/bkp/tmp/"
mkdir -p $kuda/$(date +"%Y-%m-%d")
backup_dir="$kuda/$(date +"%Y-%m-%d")"
which_dir="dir1 dir2"
for dir in $which_dir; do
    echo $otkuda$dir "->" $backup_dir
    rsync -avh $otkuda$dir $backup_dir
done;
backup_file=$kuda/backup_$(date +"%Y-%m-%d").tar.gz
tar -cvzf $backup_file $backup_dir
rm -rf $backup_dir
ls -lah $kuda
cloud_dir="/home/achern/Yandex.Disk"
cp $backup_file $cloud_dir
ls -lah $cloud_dir
