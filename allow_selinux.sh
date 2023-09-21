semanage fcontext -a -t mysqld_db_t "/mysql_tmp (/.*)?"
restorecon -Rv /mysql_tmp/
chcon -R -t mysqld_db_t /mysql_tmp
