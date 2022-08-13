#!/usr/bin/env bash

dbfile=../data/users.db
# +
function createFile () {
	if [ ! -f $dbfile ]; then
		touch $dbfile;
	fi
}
# +
function listItems () {
	declare -i i=1
	while read user
	do 
		echo "$i: $user"
		(( i++ ))
	done < ../data/users.db
}
# +
function add () {
	createFile;
	read -p "Enter user name: " username
	while [ -z $username ]; # Q: How I can pass string with space without double quotes?
	do
		read -r -p "Please enter value: " username
	done 
	until [[ $username =~ [a-zA-Z] ]];
	do
		read -r -p "Please use latin letter only: " username
	done
	read -p "Enter user role: " userrole
	while [ -z $userrole ];
	do
		read -r -p "Please enter value: " userrole
	done 
	until [[ $userrole =~ [a-zA-Z] ]];
	do
		read -r -p "Please use latin letters only: " userrole
	done
	echo "$username $userrole" >> ../data/users.db
}
# +
function backup () {
	date=`date +"%d-%m-%y"`
	mv ../data/users.db ../data/${date}-users.db.backup
}
# -
function restore () {
	latest=$(find ../data -name '*.backup' -type f) # this not save in variable and not latest
	mv $latest ../data/users.db
}
# -
function find () {
	read -p "Enter user name: " username
	while [ -z $username ]; # Q: How I can pass string with space without double quotes?
	do
		read -r -p "Please enter value: " username
	done
	
	result=listItems | grep $username;
	echo $result
	if [ !$result ]; then
	echo 'User not found'
	else
	echo $result
	fi

}
# +/-
function list () {
	#while getopt -l inverse: option; 
	#do
	#	case $option in
	#	 inverse) echo $option exit 1;;
	#	 *) echo no option exit 1;;
	#	 esac
	#done
	listItems;
}
# +
function help () {
{
echo -n " 
Commands:
	add       	Add user to the database file
	backup    	Create backup of database file
	restore		Resore latest backup
	find       	Find user in database by name
	list		List all the users in database file
	
Options:
	--inverse	Show reversed list command output 
"
exit 1
}}
# +
case $1 in 
	"add") add;;
	"help") help;;
	"backup") backup;;
	"restore") restore;;
	"find") find;;
	"list") list;;
	*) help;;
esac
