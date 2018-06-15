FROM centos

LABEL author="codingdie"

LABEL mail="codingdie@gmail.com"

USER root

RUN yum -y install git wget unzip  java-1.8.0-openjdk-devel

WORKDIR /root

RUN wget http://codingdie01-1253506722.file.myqcloud.com/download/kafka_2.11-0.9.0.0.tgz

RUN tar  -zxvf kafka_2.11-0.9.0.0.tgz

RUN rm kafka_2.11-0.9.0.0.tgz

COPY start.sh  .

COPY server.properties /root/kafka_2.11-0.9.0.0/config

RUN chmod +x /root/start.sh

ENTRYPOINT /root/start.sh




