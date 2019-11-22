#!/bin/bash
#echo "Please enter root user MySQL password!"
#echo "Note: password will be hidden when typing"
#read -s rootpasswd

read -s -p "Enter MYSQL root password: " rootpasswd
until mysql -u root -p$rootpasswd  -e ";" ; do
       read -s -p "Can't connect, please retry: " rootpasswd
done

echo "select the operation ************"
echo "  1)Create New Database And New Username "
echo "  2)Delete Table on Database " 
echo "  3)Delete Database "
echo "  4)Create Table on Database "
echo "  5)Drop Field from table "
echo "  6)ADD  Field to table "
echo "  7)Add records"

read n
case $n in
  1) 	echo "Please enter the NAME of the new MySQL database! (example: database1)"
	read dbname
	echo "Please enter the MySQL database CHARACTER SET! (example: latin1, utf8, ...)"
	read charset
	echo "Creating new MySQL database..."
	mysql -uroot -p${rootpasswd} -e "CREATE DATABASE ${dbname} /*\!40100 DEFAULT CHARACTER SET ${charset} */;" 2>/dev/null
	echo "Database successfully created!"
	echo "Showing existing databases..."
	mysql -uroot -p${rootpasswd} -e "show databases;" 2>/dev/null
	echo ""
	echo "Please enter the NAME of the new MySQL database user! (example: user1)"
	read username
	echo "Please enter the PASSWORD for the new MySQL database user!"
	echo "Note: password will be hidden when typing"
	read -s userpass
	echo "Creating new user..."
	mysql -uroot -p${rootpasswd} -e "CREATE USER ${username}@localhost IDENTIFIED BY '${userpass}';" 2>/dev/null
	echo "User successfully created!"
	echo ""
	echo "Granting ALL privileges on ${dbname} to ${username}!" 
	mysql -uroot -p${rootpasswd} -e "GRANT ALL PRIVILEGES ON ${dbname}.* TO '${username}'@'localhost';" 2>/dev/null
	mysql -uroot -p${rootpasswd} -e "FLUSH PRIVILEGES;" 2>/dev/null
	echo "The Database ${dbname} And The Username ${username} has been created";;

  2)    echo "Showing existing databases..."
        mysql -uroot -p${rootpasswd} -e "show databases;" 2>/dev/null
        echo ""
        echo "Please enter the NAME of MySQL database You Want To Delete a Table ! "
        read dbdeltable
	mysql -uroot -p${rootpasswd} ${dbdeltable} -e  "show tables;" 2>/dev/null
	echo ""
        echo "Showing exiting tables..."
        mysql -uroot -p${rootpasswd} -e "show tables;" 2>/dev/null
	echo "Please enter the NAME of table You Want To Delete ! "
	read tablename
	mysql -uroot -p${rootpasswd} -e "DROP TABLE ${dbdeltable}.${tablename}" 
	mysql -uroot -p${rootpasswd} ${dbdeltable} -e  "show tables;" 2>/dev/null
        echo ""
	echo " The table ${tablename} is deleted";;

  3)    echo "Showing existing databases..."
        mysql -uroot -p${rootpasswd} -e "show databases;"
	echo ""
	echo "Please enter the NAME of MySQL database You Want To Delete! "
        read dbdel
	mysql -uroot -p${rootpasswd} -e "DROP DATABASE ${dbdel};"
	echo "Database ${dbdel} successfully Deleted!"

	;;
  4) echo "Showing existing databases..."
        mysql -uroot -p${rootpasswd} -e "show databases;"
	echo ""
        echo "Please enter the NAME database you want to create table on it ! "
        read dbcreate
        echo "Please enter the NAME table ! "
	read tname
	echo "Please enter the colums name and datatype excatly like this 'nameofc1 int,nameofc2 varchar(255),nameofc3 varchar(255),nameofc4 varchar(255)' ! "
	read colums
	mysql -uroot -p${rootpasswd} -e "CREATE TABLE ${dbcreate}.${tname} (${colums})"
	mysql -uroot -p${rootpasswd} -e "DESCRIBE ${dbcreate}.${tname}"
        echo "table  ${tname} successfully Created!"
	;;

  5)    echo "Showing existing databases..."
        mysql -uroot -p${rootpasswd} -e "show databases;"
        echo ""
        echo "Please enter the NAME database you want to delete field table on it ! "
        read dbfield
        mysql -uroot -p${rootpasswd} ${dbfield} -e  "show tables;" 2>/dev/null
        echo ""
        echo "Please enter the NAME of table  ! "
        read tfeild
	mysql -uroot -p${rootpasswd} -e "DESCRIBE ${dbfield}.${tfeild}"
	echo ""
	echo "Please enter the NAME of feild  ! "
        read feild
	mysql -uroot -p${rootpasswd} -e "ALTER TABLE ${dbfield}.${tfeild} DROP ${feild} ;" 2>/dev/null
        mysql -uroot -p${rootpasswd} -e "DESCRIBE ${dbfield}.${tfeild}" 2>/dev/null
        echo "Field  ${feild} successfully Deleted!"	;;
  6) echo "Showing existing databases..."
        mysql -uroot -p${rootpasswd} -e "show databases;"
        echo ""
        echo "Please enter the NAME database you want to create field table on it ! "
        read db6
	mysql -uroot -p${rootpasswd} ${db6} -e  "show tables;" 2>/dev/null
        echo ""
        echo "Please enter the NAME of table  ! "
        read t6
	echo "Please enter the NAME of feild like this 'feild_naame datatype (int,varchar(255),...)' ! "
	read f6
	mysql -uroot -p${rootpasswd} -e "ALTER TABLE ${db6}.${t6} ADD ${f6} ;" 2>/dev/null
	mysql -uroot -p${rootpasswd} -e "DESCRIBE ${db6}.${t6}" 2>/dev/null
	echo "Field  ${f6} successfully Created!"    ;;

  7) echo "Showing existing databases..."
        mysql -uroot -p${rootpasswd} -e "show databases;"
        echo ""
        echo "Please enter the NAME database  ! "
        read db7
        mysql -uroot -p${rootpasswd} ${db7} -e  "show tables;" 2>/dev/null
        echo ""
        echo "Please enter the NAME of table  ! "
        read t7
        mysql -uroot -p${rootpasswd} -e "DESCRIBE ${db7}.${t7}" 2>/dev/null
	echo ""
	echo "Please enter colums names like c1,c2,c3,..."
	read c7
	echo "Please enter values of record like v1,v2,v3,..."
	read v7
	mysql -uroot -p${rootpasswd} -e  "INSERT INTO ${db7}.${t7}(${c7}) VALUES (${v7});" 2>/dev/null
	mysql -uroot -p${rootpasswd} -e " SELECT * FROM  ${db7}.${t7};" 2>/dev/null
	echo "" ;;

  *) echo "invalid option";;
esac
