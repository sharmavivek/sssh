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

## COMMANDS
#   if no option takes host by default 
# l host (this can be either IP or Hostname from etc or dnsresolv)
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

# Final Command
# ssh $HOSTNAME -l $USERNAME
COMMAND=""
HOSTNAME=""
USERNAME=""
PASSWORD=""


INDEX=""

# hidden files
G_FILENAME=
P_FILENAME=


# Variables for functions


function usage()
{
    # If no option takes host by default, as with ssh.
    echo "	h host (this can be either IP or Hostname from etc or dnsresolv)"
    echo "	n nicknames (todo unique nickname checking)"
    echo "	i index"
    echo "	g global table"
    echo "	p popular table"
    echo "	v verbose"
    echo "	+ add an entry"
    echo "	- del an entry"
}

function Check_Duplicate()
{
	# This is to check if an entry on the basis of nickname is alredy present in Global file
	echo "In Check_Duplicate"
	
}

function set_Entry_Add()
{
	echo "Enter Hostname"
	read HOSTNAME
	echo "Enter Username"
	read USERNAME
	echo "Nickname"
	read NICKNAME

    echo -e "You have entered"
    echo -e "\tNickname: $NICKNAME\t Hostname: $HOSTNAME\t Username: $USERNAME"
	echo ""
	# Check on nickname if the Entry is already present
	Check_Duplicate()
	if 
		echo "$NICKNAME,$HOSTNAME,$USERNAME,$PASSWORD" >> $G_FILENAME
	else 
		echo "Entry already present"
		sed -n "${LineNo}p" $G_FILENAME
	fi 	
}

function run_it()
{
	# PS1=">"	#to do

	echo "ssh `$USERNAME`@`$HOSTNAME`"
	spawn ssh -l $USERNAME $HOST

	set timeout 5
	expect "Are you sure you want to continue connecting (yes/no)?" {
	send "yes\r"}

	set timeout 5
	expect -nocase "*password:*" {
	send "$PASSWORD\n" }
}

function set_EntryDelete()
{
    grep -v "pattern" file >  && mv temp file
        
}

# Update is delete and then add on the nickname
function Entry_Update()
{

}

# Update is delete and then add on the nickname
function get_Entry_Index()
{
 	sed -n "${LineNo}p" $G_FILENAME

}


function get_Options()
{
	# Getting the options from the command line
	while getopts ":al:u:p:i:" opt; do
		case $opt in
		    l)
				# Set hostname
		    	HOSTNAME=-$OPTARG
		    u)
				# Set username
			  	USERNAME=-$OPTARG
			p)
				# Set password
				PASSWORD=-$OPTARG  	
		    i)
				#LOOKUP based on p or g 
			add)
				#add the entry in only g 	
		    \?)
		      echo "Invalid option: -$OPTARG" >&2
		      echo "The usage"
		      usage
		      read 
		      ;;
		esac
	done

	# USERNAME is empty, pick from the defaults, stored in personal list

	# Adding entry into the global file.
	cd $GLOBAL_PATH
	echo "$HOSTNAME, $USERNAME, $NICKNAME" >> $G_FILE

	# update Perosnal/history List

}

# The main code starts here

	echo "in main"
	echo ""
	get_Options


