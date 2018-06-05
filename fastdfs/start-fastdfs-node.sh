cd /root 
mkdir -p /root/fastdfs/${1}/client
if [ "$1" = "storage" ];then 
    sed -i '/tracker_server/d' /etc/fdfs/${1}.conf 
    sed -i '/group_name=/d' /etc/fdfs/${1}.conf 
    sed -i '/bind_addr=/d' /etc/fdfs/${1}.conf 

    echo -e "\ntracker_server=${tracker_server}\n" >> /etc/fdfs/${1}.conf 
    echo -e "\ngroup_name=${group}\n" >> /etc/fdfs/${1}.conf 
    echo -e "\bind_addr=${host}\n" >> /etc/fdfs/${1}.conf 

    rm  /etc/fdfs/mod_fastdfs.conf
    cp  fastdfs-nginx-module/src/mod_fastdfs.conf      /etc/fdfs/
    sed -i '/tracker_server/d' /etc/fdfs/mod_fastdfs.conf 
    sed -i '/group_name=/d' /etc/fdfs/mod_fastdfs.conf 
    echo -e "\ntracker_server=${tracker_server}\n" >> /etc/fdfs/mod_fastdfs.conf 
    echo -e "\ngroup_name=${group}\n" >> /etc/fdfs/mod_fastdfs.conf 

    cat groups >> /etc/fdfs/mod_fastdfs.conf 
    cat /etc/fdfs/mod_fastdfs.conf 

   
fi
if [ "$1" = "tracker" ];then   
    echo $1
fi

sed -i '/tracker_server/d' /etc/fdfs/client.conf 
sed -i '/base_path=/d' /etc/fdfs/client.conf 
echo -e "\ntracker_server=${tracker_server}\n" >> /etc/fdfs/client.conf 
echo -e "\base_path=/root/fdfs/${1}/client\n" >> /etc/fdfs/client.conf 

mkdir -p /root/fastdfs/${1}

/usr/bin/fdfs_${1}d /etc/fdfs/${1}.conf 

sleep 1

tail -f /root/fastdfs/${1}/logs/${1}d.log 
