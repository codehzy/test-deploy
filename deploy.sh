#!/bin/bash

# 设置异常的捕获和退出
 set -e
#需要部署的代码目录
CODE_DIST="dist"
#部署时项目目录名
CODE_DIR="test-deploy"
#web服务器部署目录的上一级目录
WEB_DIR="/data/wwwroot/FrontActivityWeb/"
 #web服务器账户地址
WEB_ADDR=root@10.9.28.91


#编译打包打包代码
compile_code(){
   echo "----------🎬下载资源包🎬------------"
    npm install --unsafe-perm=true --allow-root
    echo "----------🤖编译打包的🤖------------"
    npm run build
}

#将dist改成项目名后归并
tarcf_code(){
   echo "----------🐱‍💻将打包后文件归档🐱‍💻------------"
    # mv dist $CODE_DIR
    cd $CODE_DIST
    tar -zcvf web-${CODE_DIR}.tar.gz ./*
}

#拷贝到web服务器的部署目录
scp_code(){
     echo "-----------🐱‍🏍上传服务器的🐱‍🏍-------------"
    # scp -P 端口号 本地文件路径 用户名@远程服务器地址:远程路径
    scp web-${CODE_DIR}.tar.gz $WEB_ADDR:${WEB_DIR}
}

##连接web服务器先备份代码再解压包覆盖现有代码
tarxf_code(){
   ssh $WEB_ADDR "cd $WEB_DIR &&
   if [ -d "$CODE_DIR" ];then
   echo '-----------备份代码-------------'
   tar -zcvf ${CODE_DIR}.tar.gz $CODE_DIR
   else
   echo '-----------创建$CODE_DIR目录-------------'
   mkdir $CODE_DIR
   fi  &&
   echo '-----------解压代码-------------' &&
   tar -xzvf web-${CODE_DIR}.tar.gz -C $CODE_DIR"
}


#删除上传文件
del_code(){
  echo "-----------删除上传文件-------------"
    ssh $WEB_ADDR "cd $WEB_DIR && rm -rf web-${CODE_DIR}.tar.gz"
  echo "-----------🎉🎉🎉的部署成功的🎉🎉🎉-------------"
}

main(){
    compile_code;
    tarcf_code;
    scp_code;
    tarxf_code;
    # ln_code;
    del_code;
}
main
