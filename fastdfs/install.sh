
docker build -t fastdfs:1.0  . 


if [ "$1" = "tracker" ];then   
    name=${1}-${2}
    docker stop ${name}
    docker rm ${name}
    mkdir -p $3
    docker run  --network host --privileged=true --name ${name}  -d -e name=$1 -v $3:/root/fastdfs   fastdfs:1.0
fi


if [ "$1" = "storage" ];then   
    name=${1}-${2}
    docker stop ${name}
    docker rm ${name}
    docker run  --network host --name ${name}  -d -e name=$1 -e  group=$3 -e tracker_server=$4   -v $5/$1_$3:/root/fastdfs/storage   fastdfs:1.0
fi
