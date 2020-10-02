FROM fluent/fluentd:v1.11-1

USER root

RUN apk add --no-cache --update --virtual .build-deps sudo build-base ruby-dev \
  && apk add --no-cache geoip geoip-dev libmaxminddb automake autoconf libtool libc6-compat

RUN sudo gem install fluent-plugin-kafka \
  && sudo gem install fluent-plugin-prometheus \
  && sudo gem install fluent-plugin-record-modifier \
  && sudo gem install fluent-plugin-geoip

RUN sudo gem install fluent-plugin-elasticsearch \
  && sudo gem install fluent-plugin-s3 \
  && sudo gem install fluent-plugin-splunk-enterprise

RUN sudo gem sources --clear-all \
  && apk del .build-deps \
  && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

USER fluent
