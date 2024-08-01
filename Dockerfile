FROM rockylinux/rockylinux:9-ubi-init
ENV container docker
VOLUME [ "/sys/fs/cgroup" ]

RUN yum install openssh-server selinux-policy passwd python3 python3-pip -y; yum clean all
RUN ssh-keygen -A; echo '123' | passwd --stdin root 
ADD sshd_config /etc/ssh/sshd_config
RUN systemctl enable sshd

EXPOSE 22
CMD ["/usr/sbin/init"]
