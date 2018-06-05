
docker build -t fastdfs:1.0  . 


if [ "$1" = "tracker" ];then   
    name=${1}-${2}
    docker stop ${name}
    docker rm ${name}
    mkdir -p $3
    docker run --net=host --name ${name}  -d -e name=$1 -v $3:/root/fastdfs   fastdfs:1.0
fi


if [ "$1" = "storage" ];then   
    name=${1}-${3}
    docker stop ${name}
    docker rm ${name}
    docker run --net=host --name ${name}  -d -e name=$1 -e host=$2 -e  group=$4 -e tracker_server=$5   -v $6/$1_$4:/root/fastdfs/storage   fastdfs:1.0
fi
