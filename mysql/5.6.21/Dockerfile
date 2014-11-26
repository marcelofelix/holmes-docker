FROM centos:centos7
MAINTAINER Holmes Team <holmes@holmesdoc.com>

ENV       MYSQL_MAJOR         5.6
ENV       MYSQL_VERSION       5.6.21
ENV       INSTALL_DIR         /usr/local/mysql

RUN groupadd -r mysql && useradd -r -g mysql mysql

RUN yum update -y
RUN yum install -y perl tar libaio perl-DBD-MySQL

RUN DIR=$(mktemp -d) \
    && cd ${DIR} \
    && mkdir -p ${INSTALL_DIR} \
    && curl -L -O "http://dev.mysql.com/get/Downloads/MySQL-$MYSQL_MAJOR/mysql-$MYSQL_VERSION-linux-glibc2.5-x86_64.tar.gz" \
    && tar zxf mysql-$MYSQL_VERSION-linux-glibc2.5-x86_64.tar.gz -C /usr/local/mysql --strip-components=1 \
    && rm -rf /usr/local/mysql/mysql-test /usr/local/mysql/sql-bench \
    && rm -rf /usr/local/mysql/bin/*-debug /usr/local/mysql/bin/*_embedded \
    && find /usr/local/mysql -type f -name "*.a" -delete \
    && { find /usr/local/mysql -type f -executable -exec strip --strip-all '{}' + || true; } \
    && rm -rf ${DIR}

ENV PATH $PATH:/usr/local/mysql/bin:/usr/local/mysql/scripts

COPY mysql-entrypoint.sh /mysql-entrypoint.sh
RUN chmod +x /mysql-entrypoint.sh

WORKDIR /usr/local/mysql
VOLUME /var/lib/mysql

ENTRYPOINT ["/mysql-entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld", "--datadir=/var/lib/mysql", "--user=mysql"]