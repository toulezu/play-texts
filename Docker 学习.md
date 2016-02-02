#Docker 学习

官方口号：
>Build, Ship, & Run Any App, Anywhere

```
Docker 可以理解是一个轻量级的 wmware，用来创建独立的应用，对应没有太大硬件的软件开发者来说可以提供很好的程序运行环境，比如创建3个容器，每个容器里面跑一个 zookeeper，就可以模拟一个zookeeper集群。
```
##基本概念

###镜像
- 镜像是只读文件，是用来创建容器的。可以理解镜像是一个Ubuntu的安装文件，能够创建一个Ubuntu系统的容器。

###容器
- 容器由镜像创建，在容器内可以运行多个应用，每个容器都是一个完全隔离的平台。

###仓库
- **仓库**（Repository）用于存放镜像文件，比仓库更大是的**仓库注册服务器**（Registry）。比如：国外的 [Docker Hub](https://hub.docker.com/)，国内的 [Docker Pool](http://dockerpool.com/) 
- 仓库分为公开仓库（Public）和私有仓库（Private）两种形式，（有点像Maven的仓库）
- 使用 push 将镜像推送到仓库，使用 pull 将镜像拉到本地，使用 images 查看仓库中的镜像

##Docker在Ubuntu上安装

安装步骤：

- 使用管理员帐号登录ubuntu 14.04系统，保证该管理有root权限，或者可以执行sudo命令
- 检查curl包有没有安装。
```bash
$ which curl
```
- 如果curl没有安装的话，更新apt源之后，安装curl包。
```bash
$ sudo apt-get update 
$ sudo apt-get install curl
```
- 获得最新的docker安装包。
```bash
$ curl -sSL https://get.docker.com/ | sh 
```
- shell会提示你输入sudo的密码，然后开始执行安装过程。
确认Docker是否安装成功。
```bash
$ sudo docker run hello-world
```
这个命令会下载一个测试用的镜像并启动一个容器运行它。

##运行一个Ubuntu容器

- 启动容器
```bash
sudo docker run -ti --rm ubuntu /bin/bash
```
其中 `-t` 选项让Docker分配一个伪终端（pseudo-tty）并绑定到容器的标准输入上
		`-i` 选项则让容器的标准输入保持打开
`rm` 命令删除容器

- 退出容器，exit后容器内的数据不会被清空。
```bash
root@8c342c0c275c:/# exit
exit
```
*当我们输入exit后，容器就停止工作了。只有在指定的`/bin/bash`命令处于运行状态的时间，容器才会相应地处于运行状态。一旦退出容器，`/bin/bash`命令也就结束了，这时容器也就停止了。*

- 退出容器后再进入
```sh
sudo docker ps -a

CONTAINER ID        IMAGE                   COMMAND                CREATED             STATUS                         PORTS                    NAMES
a987209ab9bb        ubuntu:latest           "/bin/bash"            16 minutes ago      Exited (100) 3 minutes ago                              ubuntu-1

sudo docker start ubuntu-1
ubuntu-1

sudo docker attach ubuntu-1
```
- 删除容器
```sh
sudo docker rm ubuntu-1
ubuntu-1
```
