
# Docker-Compose连接VLAN服务器(opnsense/pfsense)
### 使用指令确认网口ID和驱动
```docker network ls```
### 控制台上输出的例子

|NETWORK 	    |ID 				      |NAME DRIVER 	  |SCOPE|
|-------------|-----------------|---------------|-----|
|XXXXXXXXXXXX |br0(NIC) 		    |macvlan 		    |local|
|XXXXXXXXXXXX |br0.10(VLAN) 	  |macvlan 		    |local|
|XXXXXXXXXXXX |bridge 			    |bridge 		    |local|
|XXXXXXXXXXXX |host 			      |host 			    |local|
|XXXXXXXXXXXX |none 			      |null 			    |local|

### 在输入指令

```docker network create -d macvlan --subnet=192.168.1.0/24 --gateway=192.168.1.1 -o parent=eth0.10 vlan-net```

网口-->parent=eth0.10
名字-->vlan-net

### 在Docker-compose.yml的文件夹内增加这几个参数

```yml
version: "3.8"
services:
    Test:
      networks:
        vlan-net:
            ipv4_address: 192.168.1.101

networks:
  vlan-net:
    external: true
