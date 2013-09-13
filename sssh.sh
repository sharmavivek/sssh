# !/bin/bash
# this is a simple ssh connector

## Requirements 
# able to ssh using nicknames (not just hostnames)
# able to ssh using popular history index no
# able to ssh using global database index no

## New Support tools
# Read config automatically from xshell
# Merge config
# Set Prompts - PS1=">"

## cmds
#   if no option takes host by default 
# l host (this can be either IP or hostname from etc or dnsresolv)
# n nicknames (todo unique nickname checking)
# i index
# g global - per user list of entires.
# p popular - history - 1 to 10 of the last used. 
# v verbose
# add an entry

## DEFAULTS
# u username -- a default username shall be used to configure
# 

# database - a set of flat files.
# host, user, nickname
# g global -- stored at /home/`$whoami`/.sssh_profile
# p personal history -- stored at local user /home/user

# Final cmd
# ssh $hostname -l $username
cmd=""
hostname=""
username=""
password=""
default_username=""


index=""

# Configuration files
readonly g_filename="~/.sssh_profile.txt"
readonly p_filename="~/.sssh_history.txt"
personal_size=20
t_file="temp.$$"
t_del_file="temp.del.$$"
t_cache="temp.cas.$$"

# Entry Point.
main

function show_usage()
{
    # If no option takes host by default, as with ssh.
    echo "	h host (IP or hostname)"
    echo "	n nicknames"
    echo "	i index"
    echo "	g global table"
    echo "	p popular table"
    echo "	v verbose"
    echo "	+ add an entry"
    echo "	- del an entry"
}

# done
function EntryAdd()
{
	
	echo "Enter nickname"
	read nickname
	grep nickname $g_filename
	
	if ($? eq 0)
	then 
		"Entry for this nickname is already present"
		echo "`grep nickname $g_filename`"
		echo "Exiting. Kindly retry."
		exit
	else
		#entry_add
		echo "Enter hostname"
		read hostname
		echo "Enter username"
		read username
		echo "Enter the password"
		read -s password
		echo "@$hostname,~$username,*$password,#$nickname" >> g_filename
	fi

    echo -e "You have entered"
    echo -e "\tnickname: $nickname\t hostname: $hostname\t username: $username"
	echo ""
}

# to review
function get_from_nickname()
{
	output=`grep '#$nickname' $g_filename`
	# Check if only 1 item is returned.

	# Next 3 lines to be deleted on review
	#hostname=`grep "#$nickname" $g_filename | awk -F "@" '{print $2}' | awk -F "," '{print $1}'`
	#username=`grep "#$nickname" $g_filename | awk -F "~" '{print $2}' | awk -F "," '{print $1}'`
	#password=`grep "#$nickname" $g_filename | awk -F "*" '{print $2}' | awk -F "," '{print $1}'`
	
	hostname=`echo $output | cut -d'@' -f2 | cut -d',' -f1`
	username=`echo $output | cut -d'~' -f2 | cut -d',' -f1`
	password=`echo $output | cut -d'*' -f2 | cut -d',' -f1`
	
	run_it
}

#done
function index_run_it()
{
 	nickname=`sed -n "${index}p" $p_filename | cut -d',' -f3`
 	
 	# Run from here
 	get_from_nickname
}


#done
function run_it()
{
	# PS1=">"	#to do

	# Check the values
	if test [ -z $hostname]
	then
		"Kindly enter hostname or IP"
		read hostname
	fi  

	if [ -z $username]	
	then
		"Kindly enter username"
		read username
	fi  

	if [ -z $password]	
	then
		"Kindly enter password"
		read -s password
	fi  

	echo "ssh $username@$hostname"

	# Adding to HISTORY file of size last 20.
	echo "$username,$hostname,$nickname" > t_personal_file
	tail -n `expr $personal_size-1` p_filename >> t_personal_file
	mv -f t_personal_file p_filename

	spawn ssh -l $username $HOST

	set timeout 5
	expect "Are you sure you want to continue connecting (yes/no)?" {
	send "yes\r"}

	set timeout 5
	expect -nocase "*password:*" {
	send "$password\n" }
}

#done
function print_history()
{
	echo -e "Username\tHostname\tNickname"
	count=0
	while read LINE ; do
		count=count+1
		hostname=`echo $LINE | cut -d'@' -f2 | cut -d',' -f1`
		username=`echo $LINE | cut -d'~' -f2 | cut -d',' -f1`
		password=`echo $LINE | cut -d'*' -f2 | cut -d',' -f1`

		echo -e "$count> $username\t$hostname\t$nickname"
	done < p_filename
}

#done
function EntryDelete()
{
    grep -v "$nickname" file > t_del_file  && mv t_del_file g_filename
}

#done
# Update is delete and then add on the nickname
function EntryUpdate()
{
	EntryDelete
	EntryAdd	
}


function get_Options()
{
	# Getting the options from the cmd line
	while getopts ":al:u:p:i:n:" opt; 
	do
		case $opt in
			l)
			# Set hostname
				hostname=-$OPTARG
			u)
			# Set username
				username=-$OPTARG
			p)
			# Set password
				password=-$OPTARG
			n)
			# Set password
				nickname=-$OPTARG
				get_from_nickname
			h)
			# LOOKUP based on p or g 
				print_history
				echo "Input the index"
				read index
				index_run_it

			add)
			#add the entry in only g 	
				\?)
				echo "Invalid option: -$OPTARG" >&2
				echo "The usage"
				show_usage
				read 
			;;
		esac
	done
	print_history
	run_it
}


# The main code starts here
function main()
{

	echo "in main..."
	echo ""
	# get options and set the globals variable for the command
	get_Options
	rm -f t_file

}
