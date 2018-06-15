docker build -t kafka:1.0  . 
name=kafka
docker stop ${name}
docker rm ${name}
docker run --name ${name}  -p 9092:9092 -p 2181:2181 -d  -e host=$1  kafka:1.0


