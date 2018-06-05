FROM centos

LABEL author="codingdie"

LABEL mail="codingdie@gmail.com"

USER root

WORKDIR /root

RUN yum -y install libtool autotools-dev automake git wget  make

RUN wget https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz

RUN tar  -zxvf  libevent-2.0.22-stable.tar.gz

RUN cd libevent-2.0.22-stable && ./configure -h && ./configure --prefix=/usr && make && make install && ls -al /usr/lib | grep libevent

RUN git clone https://github.com/happyfish100/libfastcommon.git 

RUN cd libfastcommon &&  chmod +x make.sh &&  ./make.sh &&  ./make.sh install
RUN git clone  https://github.com/happyfish100/fastdfs.git

RUN  mv  fastdfs FastDFS && cd FastDFS &&  ./make.sh &&  ./make.sh install

RUN yum -y install net-tools

RUN cd /etc/fdfs &&  cp storage.conf.sample storage.conf  &&  cp client.conf.sample client.conf  &&  cp tracker.conf.sample tracker.conf


WORKDIR /root
RUN wget https://jaist.dl.sourceforge.net/project/pcre/pcre/8.41/pcre-8.41.tar.gz
RUN wget http://www.zlib.net/zlib-1.2.11.tar.gz
RUN wget http://distfiles.macports.org/openssl/openssl-1.0.2l.tar.gz
RUN wget http://nginx.org/download/nginx-1.8.1.tar.gz
RUN wget https://jaist.dl.sourceforge.net/project/fastdfs/FastDFS%20Nginx%20Module%20Source%20Code/fastdfs-nginx-module_v1.16.tar.gz
RUN yum -y install gcc gcc-c++

WORKDIR /root
RUN ls

RUN tar -zxvf  pcre-8.41.tar.gz
WORKDIR pcre-8.41
RUN ./configure
RUN make
RUN make install

WORKDIR /root
RUN tar -zxvf zlib-1.2.11.tar.gz
WORKDIR zlib-1.2.11
RUN ./configure
RUN make
RUN make install

WORKDIR  /root
RUN tar -zxvf openssl-1.0.2l.tar.gz
WORKDIR openssl-1.0.2l
RUN ./config
RUN make
RUN make install

WORKDIR /root
RUN tar -zxvf nginx-1.8.1.tar.gz 
RUN tar -zxvf fastdfs-nginx-module_v1.16.tar.gz 

WORKDIR nginx-1.8.1
ADD config ../fastdfs-nginx-module/src/config
RUN ./configure --sbin-path=/usr/local/nginx/nginx --conf-path=/usr/local/nginx/nginx.conf --pid-path=/usr/local/nginx/nginx.pid  --with-http_ssl_module --with-openssl=../openssl-1.0.2l --with-pcre=../pcre-8.41 --with-zlib=../zlib-1.2.11 --add-module=../fastdfs-nginx-module/src
RUN cat ../fastdfs-nginx-module/src/config
RUN make 
RUN make install
# RUN chmod +x /root/install-nginx.sh  && ./install-nginx.sh

WORKDIR /root

ADD tracker.conf /etc/fdfs/tracker.conf

ADD storage.conf /etc/fdfs/storage.conf


ADD start-fastdfs-node.sh .

RUN chmod +x /root/start-fastdfs-node.sh

ADD groups .

ADD nginx.conf /usr/local/nginx/nginx.conf

ADD mod_fastdfs.conf  .

ENTRYPOINT /root/start-fastdfs-node.sh ${name}  ${host} ${group}  ${tracker_server}

EXPOSE 22122 23000
