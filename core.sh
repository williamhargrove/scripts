#!/bin/bash -x

CORE_PROCESSES="engine scribe bridge proxy bcclient"

for PROCESS in ${CORE_PROCESSES}; do
 echo "Stopping /usr/local/bin${PROCESS}"
 echo pkill -f /usr/local/bin/${PROCESS}
done

VERSION=$(egrep Commit ${HOME}/core/version |cut -d ' ' -f2)
