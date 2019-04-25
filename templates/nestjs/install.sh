#!/bin/bash

echo "Installing nestjs CLI"

selectionOpts=("With Database" "Without Database")

# select $opt in ${select}

sudo npm i -g @nestjs/cli

nest new server