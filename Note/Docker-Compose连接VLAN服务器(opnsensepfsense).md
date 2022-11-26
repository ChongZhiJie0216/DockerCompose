
# Docker-Compose连接VLAN服务器(opnsense/pfsense)
### 使用指令确认网口ID和驱动
```docker network ls```
### 控制台上输出的例子

|NETWORK 	    |ID 				      |NAME DRIVER 	  |SCOPE|
|-------------|-----------------|---------------|-----|
|4a55cf69165e |br0(NIC) 		    |macvlan 		    |local|
|46941261fc30 |br0.10(VLAN) 	  |macvlan 		    |local|
|5424fffc7098 |bridge 			    |bridge 		    |local|
|d858b412d68b |host 			      |host 			    |local|
|45c05227834e |none 			      |null 			    |local|

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
    name: br0.10
    driver: macvlan
    driver_opts:
        parent: eth0 
```