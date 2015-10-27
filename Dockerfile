FROM debian:jessie-backports
MAINTAINER Shun Yanaura <metroplexity@gmail.com>

ENV RUBY_VERSION 2.2.2
ENV FLUENTD_VERSION 0.12.16

RUN apt-get update -y && apt-get install -y --no-install-recommends \
  autoconf \
  bison \
  build-essential \
  curl \
  ca-certificates \
  git \
  curl \
  openssh-client \
  libffi-dev \
  libgdbm3 \
  libgdbm-dev \
  libncurses5-dev \
  libreadline6-dev \
  libssl-dev \
  libyaml-dev \
  zlib1g-dev \
  libjemalloc-dev \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p /fluentd/{log,etc,plugins} \
  && git clone https://github.com/tagomoris/xbuild.git /root/.xbuild \
  && /root/.xbuild/ruby-install $RUBY_VERSION /root/ruby

ENV PATH /root/ruby/bin:$PATH
ENV JEMALLOC_PATH /usr/lib/x86_64-linux-gnu/libjemalloc.so.1
ENV LD_PRELOAD $JEMALLOC_PATH

RUN gem install fluentd -v $FLUENTD_VERSION

COPY fluent.conf /fluentd/etc/
ONBUILD COPY fluent.conf /fluentd/etc/

WORKDIR /root/

ENV FLUENTD_OPT=""
ENV FLUENTD_CONF="fluent.conf"

EXPOSE 24224

CMD exec fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
