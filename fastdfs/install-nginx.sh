cd /root
wget https://jaist.dl.sourceforge.net/project/pcre/pcre/8.39/pcre-8.39.tar.gz
wget http://www.zlib.net/zlib-1.2.11.tar.gz
wget http://distfiles.macports.org/openssl/openssl-1.0.2l.tar.gz
wget http://nginx.org/download/nginx-1.8.1.tar.gz
wget https://jaist.dl.sourceforge.net/project/fastdfs/FastDFS%20Nginx%20Module%20Source%20Code/fastdfs-nginx-module_v1.16.tar.gz
tar -zxvf fastdfs-nginx-module_v1.16.tar.gz

cd /root
tar -zxvf  pcre-8.41.zip
cp -r pcre-8.41 /usr/local/pcre-8.41
cd /usr/local/pcre-8.41/
./configure
make
make install

cd /root
tar -zxvf zlib-1.2.11.tar.gz
cp  -r    zlib-1.2.11   /usr/local/zlib-1.2.11
cd /usr/local/zlib-1.2.11/
./configure
make
make install

cd  /root
tar -zxvf openssl-1.0.2l.tar.gz
cp -r openssl-1.0.2l /usr/local/openssl-1.0.2l
cd /usr/local/openssl-1.0.2l/
./config
make
make install

cd root
tar -zxvf nginx-1.8.1.tar.gz -C /usr/local
cd /usr/local/nginx-1.8.1/
./configure --sbin-path=/usr/local/nginx/nginx --conf-path=/usr/local/nginx/nginx.conf --pid-path=/usr/local/nginx/nginx.pid  --with-http_ssl_module --with-openssl=../openssl-1.0.2l --with-pcre=../pcre-8.39 --with-zlib=../zlib-1.2.11 --add-module=../fastdfs-nginx-module/src
make
make install
