# X Roleplay System - An Advanced roleplay framework for RedM

![alt text](https://wildwest.pl/redm.jpg)
Join our discord to get the newest updates and support! - https://discord.gg/FKH4uwb

## 1. Features
- Respawn/Spawn system - #######
- Loading And Saving Player Information in MySQL databse
- Multicharacter system - #######
- Money System
- Gold System
- Groups System
- Permission System
- Job System
- Unlimited Jobs
- 20 Job Grades
- Inventory System [in build]
- HUD
- Leveling and EXP system
- Up to 10 Characters - ########
- Respawn Place Selection - #########
- A lot of configuration options

## 2. Requirements
 
[fivem-mysql-async and async](https://github.com/amakuu/mysql-async-temporary)

[redem](https://github.com/kanersps/redem)

[esplugin_mysql](https://github.com/kanersps/esplugin_mysql)

## 3. Installation
- Put fivem-mysql-async into server-data/resources/ and rename it to mysql-async

- Put the redem_roleplay folder in server-data/resources/[redemrp]/ - if you don't have [redemrp], just create a new one

- Import db.sql into your mysql database

- Open your server.cfg and put below commands into it


```
set es_enableCustomData 1
set mysql_connection_string "server=ip;uid=user_name;password=very_secure_password;database=redemrp"
ensure esplugin_mysql
ensure mysql-async
ensure redem
ensure redem_roleplay
```

## 4. Usage
Join our discord to get the newest updates and support! - https://discord.gg/FKH4uwb

## 5. Credits

https://github.com/kanersps for all work he done, his scripts is the basics of the xrp framework
