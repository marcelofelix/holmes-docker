FROM holmes/java:1.7.0_71
MAINTAINER Holmes Team <holmes@holmesdoc.com>

ENV       SOLR_VERSION  4.10.2

RUN yum install -y tar lsof curl procps

RUN DIR=$(mktemp -d) \
    && cd ${DIR} \
    && curl -O -L http://apache.arvixe.com/lucene/solr/${SOLR_VERSION}/solr-${SOLR_VERSION}.tgz \
    && tar zxf solr-${SOLR_VERSION}.tgz \
    && mv solr-${SOLR_VERSION} /opt \
    && ln -s /opt/solr-${SOLR_VERSION} /opt/solr \
    && rm -rf ${DIR}

RUN mkdir -p /data
RUN cp -R /opt/solr/example/solr /data
RUN sed -ioriginal 's/..\/..\/..\//\/opt\/solr\//g' /data/solr/collection1/conf/solrconfig.xml

VOLUME ["/data/solr/collection1/data"]

EXPOSE 8983
CMD /opt/solr/bin/solr start -f -s /data/solr -a '-Dsolr.autoSoftCommit.maxTime=1000'