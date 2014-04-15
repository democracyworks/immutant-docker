FROM quay.io/democracyworks/clojure-api-build:latest

# setup synapse
RUN apt-get update
RUN apt-get install -y haproxy ruby1.9.1 ruby1.9.1-dev rubygems
RUN gem install synapse
RUN echo ENABLED=1 > /etc/default/haproxy
ADD start-synapse.sh /start-synapse.sh
ADD /supervisord-synapse.conf /etc/supervisor/conf.d/supervisord-synapse.conf
RUN mkdir /var/haproxy/

RUN apt-get install unzip -y

ENV IMMUTANT_VERSION 1.1.0-slim

RUN wget http://repository-projectodd.forge.cloudbees.com/release/org/immutant/immutant-dist/1.1.0/immutant-dist-$IMMUTANT_VERSION.zip
RUN unzip immutant-dist-$IMMUTANT_VERSION.zip

EXPOSE 8080

ADD env-configs/ /env-configs/

ADD start-immutant.sh /start-immutant.sh
ADD supervisord-immutant.conf /etc/supervisor/conf.d/supervisord-immutant.conf
