#! /bin/bash

PS3='Choose what do you want to install '

options=("Backend" "Frontend")
frontendOpts=("Vue" "React")
backendOpts=("Express" "Nestjs")
backend=false
frontend=false

function withTypescript() {
    PS3='Do you want use typescript? '
    params=("Yes" "No")
    
    select opt in "${params[@]}"
    do
        case $opt in
            "Yes")
                return 1;
                break;
            ;;
            "No")
                return 0;
                break;
            ;;
            *) echo "invalid option $REPLY";;
        esac
    done
}

function installExpress () {
    echo "installing Express"
    mkdir -p server/src
    touch server/src/index.js
    touch server/.gitignore
    echo "node_modules/" > server/.gitignore
    cd server && npm init -y
    # npm i express && npm i nodemon -D
    sed -i 7's/$/,&/' package.json
    # sed -i 's/exit 1/,&/' package.json
    sed -i '/test/a \
    "dev": "nodemon src/index.js"' package.json
}

select opt in "${options[@]}"
do
    case $opt in
        "Frontend")
            frontend=true;
            echo "Frontend"
            break;
        ;;
        "Backend")
            backend=true;
            echo "Backend"
            break;
        ;;
        "Quit")
            break
        ;;
        *) echo "invalid option $REPLY";;
    esac
done

if [ "$backend" = true ]
then
    PS3='Choose what framework do you want to install '
    echo "installing backend..."
    echo "cleanup old server..."
    rm -rf server
    
    select opt in "${backendOpts[@]}"
    do
        case $opt in
            "Express")
                withTypescript;
                
                if [ $? = 1 ]
                then
                    echo "With typescript"
                else
                    installExpress
                fi
                break;
            ;;
            "Nestjs")
                echo "installing Nestjs"
                break;
            ;;
            *) echo "invalid option $REPLY";;
        esac
    done
fi

if [ "$frontend" = true ]
then
    PS3='Choose what framework do you want to install '
    echo "installing frontend..."
    
    select opt in "${frontendOpts[@]}"
    do
        case $opt in
            "Vue")
                echo "installing vue"
                break;
            ;;
            "React")
                echo "installing react"
                break;
            ;;
            *) echo "invalid option $REPLY";;
        esac
    done
    
fi