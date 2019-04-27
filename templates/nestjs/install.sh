#!/bin/bash
source options.sh

function whatToInstall() {
    local _ans=$(choose_option_default "Would you like to install database module?" y y n)
    
    case "${_ans}" in
        [Yy]|[Yy][Ee][Ss])
            echo "Yes"
        ;;
        [Nn]|[Nn][Oo])
            echo "No"
        ;;
        *)
            echo "Invalid input"
        ;;
    esac
}


if [ $OSTYPE == msys ]
then
    npm i -g @nestjs/cli
else
    sudo npm i -g @nestjs/cli
fi

nest new server
cp -rf templates/nestjs/.prettierrc server/
cp -rf templates/nestjs/tslint.json server/

# cd server && npm i eslint eslint-config-airbnb-base @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint-config-prettier eslint-plugin-prettier -D

echo "Updating preinstalled packages"

cd server
rm readme.md
npm i @nestjs/platform-express @nestjs/core @nestjs/common @nestjs/core
echo "Installing additional dependecies"
npm i tslint-config-prettier typescript tslint prettier -D
cd ..

withDatabase=$(whatToInstall)

if [ $withDatabase == "Yes" ]
then
    /bin/bash templates/nestjs/database/install.sh
fi

