#!/bin/bash

cp /env-configs/immutant/$IMMUTANT_ENVIRONMENT/immutant-logging.xml /immutant-$IMMUTANT_VERSION/jboss/standalone/configuration/standalone.xml

for DESCRIPTOR in /servers/*/*.clj; do
  BASENAME=$(basename $DESCRIPTOR)
  cp $DESCRIPTOR /immutant-$IMMUTANT_VERSION/jboss/standalone/deployments/
  touch /immutant-$IMMUTANT_VERSION/jboss/standalone/deployments/$BASENAME.dodeploy
done

/immutant-$IMMUTANT_VERSION/jboss/bin/standalone.sh -b 0.0.0.0
