# docker-fluentd
A docker container running fluentd on Alpine Linux

## Useage

To start:

```
$ docker run yanana/fluentd:latest start
```

As this container reads _fluent.conf_ from /etc/fluent/fluent.conf, you may pass your configuration by mounting host's directory.
