FROM quay.io/democracyworks/clojure-api-build:latest

RUN apt-get install unzip -y

ENV IMMUTANT_VERSION 1.1.0-slim

RUN wget http://repository-projectodd.forge.cloudbees.com/release/org/immutant/immutant-dist/1.1.0/immutant-dist-$IMMUTANT_VERSION.zip
RUN unzip immutant-dist-$IMMUTANT_VERSION.zip

EXPOSE 8080

ADD start-immutant.sh /start-immutant.sh
ADD supervisord-immutant.conf /etc/supervisor/conf.d/supervisord-immutant.conf
