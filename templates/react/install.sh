#!/bin/bash

echo "Installing create-react-app..."
echo "ARGUMENTS $@"

if [ "$@" = 1 ]
then
    npx create-react-app client --typescript
else
    npx create-react-app client
fi