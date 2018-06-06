


if [ "$1" = "tracker" ];then   
    docker build -t fastdfs:1.0  . 
    name=${1}-${2}
    docker stop ${name}
    docker rm ${name}
    mkdir -p $3
    docker run --net=host --name ${name}  -d -e name=$1 -e port=$2 -v $3:/root/fastdfs   fastdfs:1.0
fi


if [ "$1" = "storage" ];then   
    docker build -t fastdfs:1.0  . 
    name=${1}-${3}
    docker stop ${name}
    docker rm ${name}
    mkdir -p $6/$1_$5
    docker run --net=host --name ${name}  -d -e name=$1 -e host=$2 -e port=$3 -e http=$4 -e  group=$5 -e tracker_server=$6   -v $7/$1_$5:/root/fastdfs/storage   fastdfs:1.0
fi

if [ "$1" = "nginx" ];then   
    rm proxy_nginx.conf
    cp proxy_nginx.conf.default proxy_nginx.conf
    i=3
    upstream=''
    location=''
    while [ $i -le $# ];do
       group=`eval echo '$'"${i}"`  
       i=$((i + 1))
       addr=`eval echo '$'"${i}"`  
       i=$((i + 1))
       upstream=${upstream}"upstream $group {server $addr;}"
       location=${location}"location \/$group\/M00 {proxy_pass http:\/\/${group};}"
    done;
    sed  -ig "s/replace_upstream/$upstream/g" proxy_nginx.conf
    sed  -ig "s/replace_location/$location/g" proxy_nginx.conf
    cat proxy_nginx.conf
    docker stop fdfs-nginx 
    docker rm fdfs-nginx 
    
    docker run --net=host --name fdfs-nginx   -p ${2}:80 -v `pwd`/proxy_nginx.conf:/etc/nginx/nginx.conf -d nginx
fi
