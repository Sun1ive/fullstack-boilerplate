#!/bin/bash

cd server && npm i pg typeorm @nestjs/typeorm
cd ..

if [ $OSTYPE == msys ]
then
    yes | cp -rf templates/nestjs/database/* server/
    rm server/install.sh
else
    rsync --exclude install.sh -auv templates/nestjs/database/ server/
fi
