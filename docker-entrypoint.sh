#!/bin/bash

CMD="$1"

if [ -z "${CMD}" ]; then
    if [ "${NODE_ENV}" = "development" ]; then
        CMD="dev"
    elif [ "${NODE_ENV}" = "production" ]; then
        CMD="start"
    fi
fi

echo "Running in ${NODE_ENV} mode."
echo "Executing: exec npm run ${CMD}"
exec npm run "${CMD}"
