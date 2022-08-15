#!/usr/bin/env bash

dbfile=../data/users.db
inverse=$2

function createFile () {
	if [ ! -f $dbfile ]; then
		touch $dbfile;
	fi
}

function listItems () {
	if [ -z $inverse ]; then
		nl $dbfile
	else
		nl $dbfile | sort -nr
	fi
	
}

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

function backup () {
	date=`date +"%d-%m-%y"`
	cp ../data/users.db ../data/${date}-users.db.backup
}

function restore () {
	latest=$(find ../data -name '*.backup' -type f) # this not save in variable and not latest
	mv $latest ../data/users.db
}

function find () {
	read -p "Enter user name: " username
	while [ -z $username ]; # Q: How I can pass string with space without double quotes?
	do
		read -r -p "Please enter value: " username
	done
	
	result=listItems | grep $username;

	if [ !$result ]; then
		echo 'User not found'
	else
		echo $result
	fi

}

function list () {
	listItems;
}
function help () {
echo -n " 
	Commands:
		add				Add user to the database file
		backup			Create backup of database file
		restore			Resore latest backup
		find			Find user in database by name
		list			List all the users in database file
		
	Options:
		--inverse		Show reversed list command output 
"
}

case $1 in 
	"add") add;;
	"help") help;;
	"backup") backup;;
	"restore") restore;;
	"find") find;;
	"list") list;;
	*) help;;
esac
