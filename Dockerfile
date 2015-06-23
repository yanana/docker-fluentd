FROM gliderlabs/alpine:3.2

ENV FLUENTD_VERSION 0.12.12

RUN apk-install ca-certificates ruby-dev build-base jemalloc-dev && \
  echo 'gem: --no-document' >> /etc/gemrc && \
  gem update --system && \
  gem install fluentd -v $FLUENTD_VERSION && \
  gem install fluent-plugin-td && \
  fluentd --setup /etc/fluent

ENV LD_PRELOAD /usr/lib/libjemalloc.so
