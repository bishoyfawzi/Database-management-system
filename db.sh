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
echo "  9)select with condition"
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
        echo "Please enter the NAME database ! "
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
        echo "Please enter the NAME database! "
        read db
        echo "--------------"
        ls  $HOME/DB-managemnt/${db}/
        echo "Please enter the NAME table ! "
        read tb
	echo "-----------"
	cat $HOME/DB-managemnt/${db}/${tb}
	echo ""
        echo "Please enter the number of feild like if c1,c2,c3 if u want delete c2 the enter number 2 ! "
        read f
	awk -F, '{for(i=1;i<=NF;i++)if(i!=x)f=f?f FS $i:$i;print f;f=""}' x=${f} $HOME/DB-managemnt/${db}/${tb} >> $HOME/DB-managemnt/${db}/${tb}.new
	mv $HOME/DB-managemnt/${db}/${tb}.new $HOME/DB-managemnt/${db}/${tb}
	cat $HOME/DB-managemnt/${db}/${tb}
    ;;

  7) ls  $HOME/DB-managemnt/
        echo "Please enter the NAME database! "
        read db
        echo "--------------"
        ls  $HOME/DB-managemnt/${db}/
        echo "Please enter the NAME table ! "
        read tb
        echo "-----------"
        cat $HOME/DB-managemnt/${db}/${tb}
        echo ""
	echo "Please enter values of record you want delete like v1,v2,v3,... under c1,c2,c3,..."
	read v
	echo "${v}" >> $HOME/DB-managemnt/${db}/${tb}
	echo "---------------"
	cat $HOME/DB-managemnt/${db}/${tb}
        echo "";;


  8)    ls  $HOME/DB-managemnt/
        echo "Please enter the NAME database! "
        read db
        echo "--------------"
        ls  $HOME/DB-managemnt/${db}/
        echo "Please enter the NAME table ! "
        read tb
        echo "-----------"
        cat $HOME/DB-managemnt/${db}/${tb}
        echo ""
	awk '{print NR,$0}' $HOME/DB-managemnt/${db}/${tb} >> $HOME/DB-managemnt/${db}/${tb}.new
	mv $HOME/DB-managemnt/${db}/${tb}.new $HOME/DB-managemnt/${db}/${tb}
        cat $HOME/DB-managemnt/${db}/${tb}
	echo "Please enter the number of record"
	read n
	sed ''${n}'d' $HOME/DB-managemnt/${db}/${tb} >> $HOME/DB-managemnt/${db}/${tb}.new
	mv $HOME/DB-managemnt/${db}/${tb}.new $HOME/DB-managemnt/${db}/${tb}
        cat $HOME/DB-managemnt/${db}/${tb}

        echo "" ;;
  9)  
	ls  $HOME/DB-managemnt/
        echo "Please enter the NAME database! "
        read db
        echo "--------------"
        ls  $HOME/DB-managemnt/${db}/
        echo "Please enter the NAME table ! "
        read tb
        echo "-----------"
        cat $HOME/DB-managemnt/${db}/${tb}
        echo ""
	echo "Please enter the number of field like if c1,c2,c3 if u want delete c2 the enter number 2 ! "
        read f
	echo "Please enter condition ==,<,>"
	read c
	echo "Please enter your condition value  ! "
        read co
	awk -F"," '$'${f}' '${c}'  '${co}' { print $0 }' $HOME/DB-managemnt/${db}/${tb};;
  *) echo "invalid option";;
esac
