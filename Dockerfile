# image name lzh/nova-novncproxy:kilo
FROM registry.lzh.site:5000/lzh/openstackbase:kilo

MAINTAINER Zuhui Liu penguin_tux@live.com

ENV BASE_VERSION 2015-07-20
ENV OPENSTACK_VERSION kilo


ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get -t jessie-backports install nova-novncproxy -y
RUN apt-get clean

RUN env --unset=DEBIAN_FRONTEND

RUN sed -i /NOVA_CONSOLE_PROXY_TYPE/s/.*/NOVA_CONSOLE_PROXY_TYPE=novnc/g /etc/default/nova-consoleproxy

RUN cp -rp /etc/nova/ /nova
RUN rm -rf /var/log/nova/*

VOLUME ["/etc/nova"]
VOLUME ["/var/log/nova"]

ADD entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ADD nova-novncproxy.conf /etc/supervisor/conf.d/nova-novncproxy.conf

EXPOSE 6080

ENTRYPOINT ["/usr/bin/entrypoint.sh"]