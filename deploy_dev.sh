#!/bin/bash
# 禁止设置为空，否则会导致删除服务器上所有项目。
base_dir=test-deploy
password=Jinbei123

function build_dev(){
    npm run build:dev;
}

function pack_dist(){
    tar -czvf dist.tar ./dist;
}

function cp_to_server(){
    # chmod +x cp.exp&&./cp.exp $base_dir
    expect -c "
        set timeout -1
        spawn scp ./dist.tar root@192.168.1.94:/data/wwwroot/default/$base_dir
        expect  \"*password:\"
        send \"Jinbei123\r\n\"
        interact
    "
}

# 解压部署
function exit_deploy(){
    expect -c "
        set timeout -1
        spawn ssh root@192.168.1.94 \"cd /data/wwwroot/default/$base_dir&&tar -xzvf dist.tar&&mv ./dist/* ./&&rm -rf ./dist ./dist.tar\"
        expect  \"*password:\"
        send \"Jinbei123\r\n\"
        interact
    "
}

# 删除服务器项目目录
function rmall(){
    expect -c "
        set timeout -1
        spawn ssh root@192.168.1.94 \"cd /data/wwwroot/default/$base_dir&&rm -rf * \"
        expect  \"*password:\"
        send \"Jinbei123\r\n\"
        interact
    "
}

# 删除打包后的dist
function removeDistTar(){
    rm -rf ./dist.tar
}

run(){
    build_dev;
    pack_dist;
    rmall;
    cp_to_server;
    exit_deploy;
    removeDistTar;
}
run;
