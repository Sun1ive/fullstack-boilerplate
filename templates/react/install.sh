#!/bin/bash

echo "Installing create-react-app..."

if [ $@ == "Yes" ]
then
    echo "installing client with typescript"
    npx create-react-app client --typescript
else
    echo "installing client without typescript"
    npx create-react-app client
fi