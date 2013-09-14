#SSSH 
---

A simple ssh wrapper to connect using some default settings


## Requirements 
1. able to ssh using nicknames (not just hostnames)
2. able to ssh using popular history index no *hint: cursor based*
3. able to ssh using default **username**
4. able to ssh using default **password**

 

##  cmds 
-    if no option takes host by default  
-  l host (this can be either IP or hostname from etc or dnsresolv)  
-  n nicknames (todo unique nickname checking)  
-  i index  
-  g global per user list of entires.  
-  p popular history 1 to 10 of the last used.   
-  v verbose  
-  add an entry  

## Defaults
- u username *a default username shall be used to configure*
 

## Design
- database *a set of flat files*  
	- host, user, nickname, password
- g global *stored at /home/`$whoami`/.sssh_profile*
- p personal history *stored at /home/`$whoami`/.sssh_history*
- set encrypted password
