# Docker安装
```
curl -fsSL https://get.docker.com/ | sudo sh
```

## Docker Compose 指令

创建+启动
```
docker compose up -d
```

以命名脚本创建+启动
```
docker compose -f xxx.yml up -d
```

启动 
```
docker compose start
```

关闭 
```
docker compose stop 
```

删除 
```
docker compose down
```
