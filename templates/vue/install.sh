#!/bin/bash

echo "Installing vue-cli..."

if [ $OSTYPE == msys ]
then
    npm i -g @vue/cli
else
    sudo npm i -g @vue/cli
fi


vue create client