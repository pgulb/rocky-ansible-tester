FROM rockylinux/rockylinux:8.4
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]

RUN yum install openssh-server selinux-policy passwd whoami -y; yum clean all
RUN ssh-keygen -A; echo '123' | passwd --stdin root 
ADD sshd_config /etc/ssh/sshd_config
RUN systemctl enable sshd

EXPOSE 22
CMD ["/usr/sbin/init"]
