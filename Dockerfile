FROM gliderlabs/alpine:3.2

ENV FLUENTD_VERSION 0.12.15
ENV JEMALLOC_PATH /usr/lib/libjemalloc.so

COPY runfluentd /usr/local/bin/runfluentd

RUN apk-install ca-certificates ruby-dev build-base jemalloc-dev && \
  echo 'gem: --no-document' >> /etc/gemrc && \
  gem update --system && \
  gem install fluentd -v $FLUENTD_VERSION && \
  fluent-gem install fluent-plugin-td && \
  fluentd --setup /etc/fluent && \
  mkdir /var/run/fluentd && \
  chmod 755 /usr/local/bin/runfluentd && \
  ulimit -n 65536


ENTRYPOINT ["/usr/local/bin/runfluentd"]
