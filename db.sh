#!/bin/bash
#This script is written by Bishoy Fawzi
#This script can add,remove databases , add,remove table , add,remove fields , add,remove record 


mkdir "$HOME/DB-managemnt" 2>/dev/null
echo "select the operation ************"
echo "  1)Create  Database "
echo "  2)Delete Database " 
echo "  3)Create Table "
echo "  4)Delete Table  "
echo "  5)Add Field from table "
echo "  6)Delete  Field to table "
echo "  7)Add records"
echo "  8)Delete records"
echo "  9)Select records with condition"
read n
case $n in
  1) 	echo "Please enter the NAME of the db! (example: database1)"
	read dbname
	mkdir "$HOME/DB-managemnt/${dbname}" 2>/dev/null
	ls  $HOME/DB-managemnt/
        echo " The DB ${dbname} is created ";;

  2)    ls  $HOME/DB-managemnt/
        echo ""
        echo "Please enter the NAME of  database You Want To Delete a Table ! "
        read dbname
	rm -rf $HOME/DB-managemnt/${dbname}
	echo " The DB ${dbname} is deleted"
        ls  $HOME/DB-managemnt/ ;;

  3)    ls  $HOME/DB-managemnt/
	echo "Please enter the NAME database you want to create table on it ! "
	read db
	echo "Please enter the NAME table ! "
	read tb
	touch $HOME/DB-managemnt/${db}/${tb}.csv
	echo " The table ${tb} is created"
	ls  $HOME/DB-managemnt/${db}/
	;;

  4)    ls  $HOME/DB-managemnt/
        echo "Please enter the NAME database you want to delete table on it ! "
        read db
	echo "--------------"
	ls  $HOME/DB-managemnt/${db}/
        echo "Please enter the NAME table ! "
        read tb
        rm $HOME/DB-managemnt/${db}/${tb}
        echo " The table ${tb} is Deleted"
        ls  $HOME/DB-managemnt/${db}/ 
	;;

  5)    ls  $HOME/DB-managemnt/
        echo "Please enter the NAME database you want to delete table on it ! "
        read db
        echo "--------------"
        ls  $HOME/DB-managemnt/${db}/
        echo "Please enter the NAME table ! "
        read tb
	echo "Please enter the all feild like c1,c2,c3,....... ! "
        read f
        echo "${f}" >> $HOME/DB-managemnt/${db}/${tb}
        cat $HOME/DB-managemnt/${db}/${tb}
	;;
  6)  ls  $HOME/DB-managemnt/
        echo "Please enter the NAME database you want to delete table on it ! "
        read db
        echo "--------------"
        ls  $HOME/DB-managemnt/${db}/
        echo "Please enter the NAME table ! "
        read tb
        echo "Please enter the number of feild ! "
        read f
	awk -F, '{for(i=1;i<=NF;i++)if(i!=x)f=f?f FS $i:$i;print f;f=""}' x=${f} $HOME/DB-managemnt/${db}/${tb} >> $HOME/DB-managemnt/${db}/${tb}.new
	mv $HOME/DB-managemnt/${db}/${tb}.new $HOME/DB-managemnt/${db}/${tb}
	colum -t  $HOME/DB-managemnt/${db}/${tb}

    ;;

  7) 
  8) echo "Showing existing databases..."
        mysql -uroot -p${rootpasswd} -e "show databases;"
        echo ""
        echo "Please enter the NAME database  ! "
        read db8
        mysql -uroot -p${rootpasswd} ${db8} -e  "show tables;" 2>/dev/null
        echo ""
        echo "Please enter the NAME of table  ! "
        read t8
        mysql -uroot -p${rootpasswd} -e "DESCRIBE ${db8}.${t8}" 2>/dev/null
        echo ""
        echo "Please enter colums names like c1,c2,c3,..."
        read c8
        mysql -uroot -p${rootpasswd} -e " SELECT * FROM  ${db8}.${t8};" 2>/dev/null
	echo ""
        echo "Please enter values of record you want delete like v1,v2,v3,... if string Please add between '' "
        read v8
	mysql -uroot -p${rootpasswd} -e  "DELETE FROM ${db8}.${t8} WHERE ${c8}=${v8};"
        mysql -uroot -p${rootpasswd} -e " SELECT * FROM  ${db8}.${t8};" 2>/dev/null
        echo "" ;;

  9) echo "Showing existing databases..."
        mysql -uroot -p${rootpasswd} -e "show databases;"
        echo ""
        echo "Please enter the NAME database  ! "
        read db9
        mysql -uroot -p${rootpasswd} ${db9} -e  "show tables;" 2>/dev/null
        echo ""
        echo "Please enter the NAME of table  ! "
        read t9
	echo "Please enter your condition like >1,<1,=1 "
	read co9
        mysql -uroot -p${rootpasswd} -e "DESCRIBE ${db9}.${t9}" 2>/dev/null
        echo ""
        echo "Please enter colums name like c1"
        read c9
#        echo "Please enter values of your condition"
#        read v9
        mysql -uroot -p${rootpasswd} -e  "SELECT * FROM ${db9}.${t9} WHERE ${c9}${co9};"
        echo "" ;;

  *) echo "invalid option";;
esac
