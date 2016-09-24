FROM centos:7

#Maintainer
MAINTAINER Caocao <martin.mengdj@gmail.com>
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
#VOLUME [ "/sys/fs/cgroup" ]
#CMD ["/usr/sbin/init"]

# Install curl  
RUN yum install -y curl wget
RUN yum update && yum install -y \
	curl \
	wget

# update source  
RUN cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo 
RUN wget -P /etc/yum.repos.d/ http://mirrors.aliyun.com/repo/epel-7.repo  

RUN yum clean all && yum makecache