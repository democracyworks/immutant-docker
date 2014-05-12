#!/bin/bash

export IMMUTANT_HOME="/immutant-$IMMUTANT_VERSION-slim"

cp /env-configs/immutant/$IMMUTANT_ENVIRONMENT/standalone.xml $IMMUTANT_HOME/jboss/standalone/configuration/standalone.xml

for DESCRIPTOR in /servers/*/*.clj; do
  BASENAME=$(basename $DESCRIPTOR)
  cp $DESCRIPTOR $IMMUTANT_HOME/jboss/standalone/deployments/
  touch $IMMUTANT_HOME/jboss/standalone/deployments/$BASENAME.dodeploy
done

$IMMUTANT_HOME/jboss/bin/standalone.sh -b 0.0.0.0
