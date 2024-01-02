# yum -y install oracle-database-preinstall-19c

#zip file install:
	mkdir -p /u01/app/oracle/product/19.3.0/db_1
	chown -R oracle /u01/app/oracle/product/19.3.0/db_1
	chmod -R 777 /u01/app/oracle/product/19.3.0/db_1
	unzip -d /u01/app/oracle/product/19.3.0/db_1 LINUX.X64 193000 db home.zip
	cd /u01/app/oracle/product/19.3.0/db_1

#rpm install:
	1) download the rpm file to the server
	2) # cd /{file location}
	3) # yum -y localinstall oracle-database-ee-19c-1.0-1.x86_64.rpm

	export ORACLE HOME=/opt/oracle/product/19c/dbhome_1
	export ORACLE SID=ORCLCDB

	ssh -X oracle@172.21.22.29
mrv1
# .bash_profile
# Get the aliases and functions

if [ -f ~/.bashre ]; then
. ~/.bashrc
fi

# User specific environment and startup programs
	PATH=$PATH: $HOME/bin
	export PATH
	export ORACLE_SID=ORCLCDB
	export ORACLE_HOME=/opt/oracle/product/19c/dbhome_1
	export TNS_ADMIN=/opt/oracle/product/19c/dbhome_1/network/admin
	export PATH=$PATH:$ORACLE_HOME/bin
	sqlplus sys/manager as sysdba


change pass for user:
	ALTER USER system IDENTIFIED BY systems123;


create listener:
https://www.server-world.info/en/note?os=CentOS_7&p=oracle19c&f=3