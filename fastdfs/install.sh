
docker build -t fastdfs:1.0  . 


if [ "$1" = "tracker" ];then   
    name=${1}-${2}
    docker stop ${name}
    docker rm ${name}
    mkdir -p $3
    docker run --net=host --name ${name}  -d -e name=$1 -e port=$2 -v $3:/root/fastdfs   fastdfs:1.0
fi


if [ "$1" = "storage" ];then   
    name=${1}-${3}
    docker stop ${name}
    docker rm ${name}
    mkdir -p $6/$1_$5
    docker run --net=host --name ${name}  -d -e name=$1 -e host=$2 -e port=$3 -e http=$4 -e  group=$5 -e tracker_server=$6   -v $7/$1_$5:/root/fastdfs/storage   fastdfs:1.0
fi
