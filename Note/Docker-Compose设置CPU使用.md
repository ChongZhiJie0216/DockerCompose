# Docker-Compose设置CPU使用

###在Docker-Compose文件里Service里面加上以下参数
```yml
version: "3.8"
services:
      deploy:
        resources:
            limits:
              cpus: CPU线程数量
```
## CPU线程数量请根据CPU型号填写，如果不清楚请去网上查询

|CPU线程数量|               线程数量               |
|----------|-------------------------------------|
|     4    |0,1,2,3                              |
|     8    |0,1,2,3,4,5,6,7                      |
|     6    |0,1,2,3,4,5,6,7,8,9,10,11            |
|     16   |0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15|
