FROM ruby:2.3-slim
MAINTAINER tobias.michaelsen@karnovgroup.com

ENV ORACLE_HOME "/usr/lib/oracle/11.2/client64"
ENV LD_LIBRARY_PATH "$ORACLE_HOME/lib"
ENV PATH "$PATH:$ORACLE_HOME/bin"

COPY vendor/11.2/*.rpm /tmp/

RUN set -ex && \
  BUILD_PACKAGES='alien build-essential libaio-dev' && \
  apt-get update && \
  apt-get install -y --no-install-recommends $BUILD_PACKAGES libaio1 && \
  for f in /tmp/oracle-*.rpm; do alien -i $f; done && \
  apt-get purge -y --auto-remove $BUILD_PACKAGES && \
  rm -rf /tmp/*.rpm

CMD ["sh"]
