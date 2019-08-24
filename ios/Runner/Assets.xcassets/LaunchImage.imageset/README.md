## 简要说明

有不知道后台接口的同学请去  [ 这个地址 ]( https://github.com/Binaryify/NeteaseCloudMusicApi) 去下载网易云音乐的 NodeJs 后台。

有不了解`NodeJs `的老铁在[这个地方](https://nodejs.org/zh-cn/ ) 下载和安装nodejs环境。

nodeJS环境安装完成之后运行以下命令：

```shell
#全局安装nrm
npm i -g nrm
#将npm的源切换到taobao来加速下载
nrm use taobao
#cd 到网易云音乐的文件目录下 运行
#linux/mac
sudo npm i
#win
npm i
#安装完成之后将服务启动
npm run start
```

出现一下就说明服务已经启动

![image-20190816092142909](/Volumes/document/asdfa/cloudMusic_flutter/image-20190816092142909.png)

有玩过`docker`的老铁，在终端运行以下代码

```shell
#拉取后台镜像
docker pull binaryify/netease_cloud_music_api
#启动服务，将端口映射到本地的 3000端口
docker run -d -p 3000:3000 --name netease_cloud_music_api binaryify/netease_cloud_music_api
```
