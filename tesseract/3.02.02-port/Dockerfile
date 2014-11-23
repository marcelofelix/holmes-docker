FROM holmes/tesseract:3.02.02
MAINTAINER Holmes Team <holmes@holmesdoc.com>

RUN yum install -y tar

RUN DIR=$(mktemp -d) \
    && cd ${DIR} \
    && curl -L -O https://tesseract-ocr.googlecode.com/files/tesseract-ocr-${TESSERACT_MAJOR_VERSION}.por.tar.gz \
    && tar xvf tesseract-ocr-${TESSERACT_MAJOR_VERSION}.por.tar.gz \
    && cp tesseract-ocr/tessdata/por.traineddata /usr/share/tesseract/tessdata/ \
    && rm -rf ${DIR}

ENTRYPOINT ["tesseract"]
CMD ["--version"]