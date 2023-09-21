#!/bin/bash

backup_file=/data/mysql_datadir/mysql_tmp.tar
old_backup=/data/mysql_datadir/mysql_tmp
backup_target=/mysql_tmp

if [ -f "$backup_file" ];then
        old_bk_file_dt=$(stat -c'%.16w' $backup_file | sed 's/[-:]//g'| sed 's/ /_/g')
        old_file_new_name="${old_backup}_${old_bk_file_dt}".tar
        echo $backup_file " already exists, rename as " $old_file_new_name
        mv $backup_file $old_file_new_name
fi



if [ -d "$backup_target" ];then
        ls -al $backup_target/*
else
        echo "No folder to backup: " $backup_target
        exit 1
fi



echo '###################################'
systemctl stop mysqld
systemctl status mysqld

echo '###################################'
tar cf $backup_file -C $backup_target .
touch $backup_file
ls -l $backup_file

echo '###################################'
systemctl start mysqld
systemctl status mysqld
echo '###################################'
