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

echo "Updating preinstalled packages"

cd server
rm readme.md
npm i @nestjs/platform-express @nestjs/core @nestjs/common @nestjs/core
echo "Installing additional dependecies"
npm i tslint-config-prettier typescript tslint prettier ts-node-dev -D
sed -i 's/ts-node/ts-node-dev/g' nodemon.json
cd ..

withDatabase=$(whatToInstall)

if [ $withDatabase == "Yes" ]
then
    /bin/bash templates/nestjs/database/install.sh
fi

