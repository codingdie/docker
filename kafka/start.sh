cd  /root/kafka_2.11-0.9.0.0
nohup sh bin/zookeeper-server-start.sh config/zookeeper.properties >zk.log 2>&1 &
sleep 3
sed -i "s/<hostname routable by clients>/${host}/g" config/server.properties
nohup sh bin/kafka-server-start.sh config/server.properties >kafka.log 2>&1 &
tail -f kafka.log
