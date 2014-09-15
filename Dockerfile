FROM quay.io/democracyworks/clojure-api-supervisor:latest
MAINTAINER Democracy Works, Inc. <dev@democracy.works>

# setup synapse
RUN apt-get update && apt-get install -y haproxy ruby1.9.1 ruby1.9.1-dev patch make unzip
RUN gem install synapse --version "0.10.0" --no-rdoc --no-ri
RUN echo ENABLED=1 > /etc/default/haproxy
ADD start-synapse.sh /start-synapse.sh
ADD /supervisord-synapse.conf /etc/supervisor/conf.d/supervisord-synapse.conf
RUN mkdir /var/haproxy/

ENV IMMUTANT_VERSION 1.1.1

RUN wget http://repository-projectodd.forge.cloudbees.com/release/org/immutant/immutant-dist/${IMMUTANT_VERSION}/immutant-dist-${IMMUTANT_VERSION}-slim.zip
RUN unzip immutant-dist-${IMMUTANT_VERSION}-slim.zip

EXPOSE 8080

ADD env-configs/ /env-configs/

ADD start-immutant.sh /start-immutant.sh
ADD supervisord-immutant.conf /etc/supervisor/conf.d/supervisord-immutant.conf
