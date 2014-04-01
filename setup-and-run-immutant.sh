#!/bin/bash

for IMA in /servers/**/*.ima; do
  SIMPLE_NAME=$(basename $IMA .ima)
  echo "{:root \"$IMA\" :resolve-dependencies false}" > /immutant-$IMMUTANT_VERSION/jboss/standalone/deployments/$SIMPLE_NAME.clj
  touch /immutant-$IMMUTANT_VERSION/jboss/standalone/deployments/$SIMPLE_NAME.clj.dodeploy
done

/immutant-$IMMUTANT_VERSION/jboss/bin/standalone.sh
