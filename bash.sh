#!/bin/bash

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
    mkdir server
    touch server/.gitignore
    echo "node_modules/" > server/.gitignore
    rsync -avu templates/express/ server/
    cd server && /bin/bash install.sh
}

function installVue() {
    echo "Installing vue..."
    mkdir -p client
    rsync -auv templates/vue/ client/
    /bin/bash client/install.sh
}

function installReact() {
    echo "Installing react..."
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
            break;
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
                    break;
                else
                    installExpress
                    break;
                fi
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
    echo "cleanup old client..."
    rm -rf client
    
    select opt in "${frontendOpts[@]}"
    do
        case $opt in
            "Vue")
                echo "installing vue"
                installVue
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