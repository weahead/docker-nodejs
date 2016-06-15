#!/bin/bash

if [ "${NODE_ENV}" = "development" ]; then
  echo "Running in development mode."
  echo "Executing: exec npm run dev"
  exec npm run dev
elif [ "${NODE_ENV}" = "production" ]; then
  echo "Running in production mode."
  echo "Executing: exec npm start"
  exec npm start
fi
