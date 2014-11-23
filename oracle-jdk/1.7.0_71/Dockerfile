FROM centos:centos7
MAINTAINER Holmes Team <holmes@holmesdoc.com>

# Downlaoad
RUN curl -SL --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
         "http://download.oracle.com/otn-pub/java/jdk/7u71-b14/jdk-7u71-linux-x64.rpm" \
         -o jdk-7u71-linux-x64.rpm

# Instalação
RUN yum install -y jdk-7u71-linux-x64.rpm \
    && /usr/sbin/alternatives --install /usr/bin/java java /usr/java/jdk1.7.0_71/bin/java 1 \
    && /usr/sbin/alternatives --set java /usr/java/jdk1.7.0_71/bin/java \
    && rm jdk-7u71-linux-x64.rpm

ENV JAVA_HOME /usr/java/jdk1.7.0_71
ENV PATH $PATH:$JAVA_HOME/bin

CMD ["java"]