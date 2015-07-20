# 环境变量
- RABBIT_HOST: rabbitmq IP
- RABBIT_USERID: rabbitmq user
- RABBIT_PASSWORD: rabbitmq user 的 password
- VNCSERVER_PROXYCLIENT_ADDRESS: novnc访问地址
- MY_IP: my_ip

# volumes:
- /opt/openstack/nova-novncproxy/: /etc/nova
- /opt/openstack/log/nova-novncproxy/: /var/log/nova/

# 启动nova-novncproxy
docker run -d --name nova-novncproxy \
    -v /opt/openstack/nova-novncproxy/:/etc/nova \
    -v /opt/openstack/log/nova-novncproxy/:/var/log/nova/ \
    -e RABBIT_HOST=10.64.0.52 \
    -e RABBIT_USERID=openstack \
    -e RABBIT_PASSWORD=openstack \
    -e VNCSERVER_PROXYCLIENT_ADDRESS=10.64.0.52 \
    -e MY_IP=10.64.0.52 \
    10.64.0.50:5000/lzh/nova-consoleauth:kilo