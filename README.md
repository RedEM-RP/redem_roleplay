# RedEM Roleplay System - An Advanced roleplay framework for RedEM

![alt text](https://wildwest.pl/redm.jpg)
Join our discord to get the newest updates and support! - https://discord.gg/nbmTmZR

## 1. Features
- Respawn/Spawn system - [redemrp_respawn](https://github.com/RedEM-RP/redemrp_respawn)
- Loading And Saving Player Information in MySQL databse
- Multicharacter system - [redemrp_identity](https://github.com/RedEM-RP/redemrp_identity)
- Money System
- Gold System
- Groups System
- Permission System
- Job System
- Unlimited Jobs
- Unlimited Job Grades
- Inventory System [redemrp_inventory](https://github.com/RedEM-RP/redemrp_inventory)
- Customizable HUD
- Fallout 4 like dialog system [redemrp_dialog](https://github.com/RedEM-RP/redemrp_dialog)
- Leveling and EXP system (Unlimited Level support)
- Up to 10 Characters - [redemrp_identity](https://github.com/RedEM-RP/redemrp_identity)
- Respawn Place Selection - [redemrp_respawn](https://github.com/RedEM-RP/redemrp_respawn)
- A lot of configuration options

## 2. Requirements
 
[mysql-async](https://github.com/amakuu/mysql-async-temporary)

[redem](https://github.com/kanersps/redem)

[esplugin_mysql](https://github.com/RedEM-RP/esplugin_mysql)

## 3. Installation
https://docs.kanersps.pw/docs/redem/installation

OR

- Put fivem-mysql-async into server-data/resources/ and rename it to mysql-async

- Put the redem_roleplay folder in server-data/resources/[redemrp]/ - if you don't have [redemrp], just create a new one

- First start of server will create everything for you, all you have to do is make sure you have an active MySQL instance running and create a database named 'redemrp'

- Open your server.cfg and put below commands into it


```
set es_enableCustomData 1
set mysql_connection_string "server=ip;uid=user_name;password=very_secure_password;database=redemrp"
ensure esplugin_mysql
ensure mysql-async
ensure redem
ensure redem_roleplay
```

## 4. Documentation and Usage
We have our documentation at https://docs.kanersps.pw/docs/redem/

## 5. Credits

Main code & quality assurance: https://github.com/kanersps

Main contributor: https://github.com/amakuu


And of course everyone who made a PR!
