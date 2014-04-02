#!/bin/bash

for DESCRIPTOR in /servers/*/*.clj; do
  BASENAME=$(basename $DESCRIPTOR)
  cp $DESCRIPTOR /immutant-$IMMUTANT_VERSION/jboss/standalone/deployments/
  touch /immutant-$IMMUTANT_VERSION/jboss/standalone/deployments/$BASENAME.dodeploy
done

/immutant-$IMMUTANT_VERSION/jboss/bin/standalone.sh -b 0.0.0.0
