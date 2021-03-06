cd /root 
mkdir -p /root/fastdfs/${name}
mkdir -p /root/fastdfs/${name}/client

sed -i '/tracker_server/d' /etc/fdfs/client.conf 
sed -i '/base_path/d' /etc/fdfs/client.conf 
echo -e "\nbase_path=/root/fastdfs/${name}/client/\n" >> /etc/fdfs/client.conf 

if [ "$1" = "storage" ];then 
    sed -i '/tracker_server/d' /etc/fdfs/${name}.conf 
    sed -i '/group_name=/d' /etc/fdfs/${name}.conf 
    sed -i '/bind_addr=/d' /etc/fdfs/${name}.conf 
    sed -i '/port=/d' /etc/fdfs/${name}.conf 
    sed -i '/http.server_port=/d' /etc/fdfs/${name}.conf 

    echo -e "\ntracker_server=${tracker_server}\n" >> /etc/fdfs/${name}.conf 
    echo -e "\ngroup_name=${group}\n" >> /etc/fdfs/${name}.conf 
    echo -e "\nbind_addr=${host}\n" >> /etc/fdfs/${name}.conf 
    echo -e "\nport=${port}\n" >> /etc/fdfs/${name}.conf 
    echo -e "\nhttp.server_port=${http}\n" >> /etc/fdfs/${name}.conf 

    rm  /etc/fdfs/mod_fastdfs.conf
    cp  /root/mod_fastdfs.conf      /etc/fdfs/
    sed -i '/tracker_server/d' /etc/fdfs/mod_fastdfs.conf 
    sed -i '/group_name=/d' /etc/fdfs/mod_fastdfs.conf 
    sed -i '/storage_server_port=/d' /etc/fdfs/mod_fastdfs.conf 

    echo -e "\ntracker_server=${tracker_server}\n" >> /etc/fdfs/mod_fastdfs.conf 
    echo -e "\ngroup_name=${group}\n" >> /etc/fdfs/mod_fastdfs.conf 
    echo -e "\nstorage_server_port=${port}\n" >> /etc/fdfs/mod_fastdfs.conf 

    cat groups >> /etc/fdfs/mod_fastdfs.conf 
    cat /etc/fdfs/mod_fastdfs.conf 

    sed -i "s/replace_port/${http}/g" /usr/local/nginx/nginx.conf
    /usr/local/nginx/nginx -c /usr/local/nginx/nginx.conf 

    echo -e "\ntracker_server=${tracker_server}\n" >> /etc/fdfs/client.conf 

fi
if [ "$1" = "tracker" ];then   
    echo -e "\ntracker_server=127.0.0.1:22122\n" >> /etc/fdfs/client.conf 
fi



/usr/bin/fdfs_${name}d /etc/fdfs/${name}.conf 

sleep 1

tail -f /root/fastdfs/${name}/logs/${name}d.log 
