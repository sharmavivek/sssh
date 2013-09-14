#SSSH 
---

A simple ssh wrapper to connect using some default settings


## Requirements 
 1. able to ssh using nicknames (not just hostnames)  
 - able to ssh using popular history index no  
 - able to ssh using global database index no  
 - 

 New Support tools
 Read config automatically from xshell
 Merge config
 Set Prompts - PS1=">"

##  cmds 
-    if no option takes host by default  
-  l host (this can be either IP or hostname from etc or dnsresolv)  
-  n nicknames (todo unique nickname checking)  
-  i index  
-  g global per user list of entires.  
-  p popular history 1 to 10 of the last used.   
-  v verbose  
-  add an entry  

 DEFAULTS
 u username -- a default username shall be used to configure
 

 database - a set of flat files.
 host, user, nickname
 g global -- stored at /home/`$whoami`/.sssh_profile
 p personal history -- stored at local user /home/user

 Final cmd
 ssh $hostname -l $username