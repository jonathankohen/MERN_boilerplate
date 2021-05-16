#!/bin/bash

# Variables
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Intro
echo "
			   /~\   Hey Yoni!
                          (O O) _/                 
                          _\=/_                         
          ___            /  _  \                         
         / ()\          //|/.\|\\                        
       _|_____|_       ||  \_/  ||                       
      | | === | |      || |\ /| ||                       
      |_|  O  |_|       # \_ _/ #                        
       ||  O  ||          | | |                          
       ||__*__||          | | |                          
      |~ \___/ ~|         []|[]                          
      /=\ /=\ /=\         | | |                          
______[_]_[_]_[_]________/_]_[_\_____
"

echo "\n${GREEN}Let's start by gathering some variable data.${NC}\n\n${BLUE}Type 'exit' at any time to exit.${NC}\n"

# Getting environment variables
read -r -p "Enter project name: `echo $'\n> '`" PROJECT_NAME
if [[ "$PROJECT_NAME" == [eE][xX][iI][tT] ]]; then
	clear
	echo "
            Miss you, we will!
    __.-._  _/
    '-._\"7'
     /'.-c
     |  /T
    _)_/LI"

	echo "\n${GREEN}Take care!${NC}\n"
	exit
fi

# TODO: only accept numbers for port
while [[ ! $PORT =~ ^[0-9]{4} ]]; do
    if [[ "$PORT" == [eE][xX][iI][tT] ]]; then
        clear
        echo "
                Miss you, we will!
        __.-._  _/
        '-._\"7'
        /'.-c
        |  /T
        _)_/LI"

        echo "\n${GREEN}Take care!${NC}\n"
        exit
    fi
    read -p "Enter port number: " PORT
done

read -r -p "Enter secret: `echo $'\n> '`" SECRET_KEY
if [[ "$SECRET_KEY" == [eE][xX][iI][tT] ]]; then
	clear
	echo "
            Miss you, we will!
    __.-._  _/
    '-._\"7'
     /'.-c
     |  /T
    _)_/LI"

	echo "\n${GREEN}Take care!${NC}\n"
	exit
fi

read -r -p "Enter database name: `echo $'\n> '`" DB_NAME
if [[ "$DB_NAME" == [eE][xX][iI][tT] ]]; then
	clear
	echo "
            Miss you, we will!
    __.-._  _/
    '-._\"7'
     /'.-c
     |  /T
    _)_/LI"

	echo "\n${GREEN}Take care!${NC}\n"
	exit
fi

echo "\nProject name: $PROJECT_NAME
Port #: $PORT
Secret: $SECRET
Database name: $DB_NAME
"

read -r -p "Look correct? [Y/n] " INPUT

case $INPUT in
	# If yes, run script
	[yY][eE][sS]|[yY])
	echo "\n${GREEN}Your data is safe with us.${NC}\n
                    .==.
                   ()''()-.
        .---.       ;--; /
      .'_:___\". _..'.  __'.
      |__ --==|'-''' \'...;
      [  ]  :[|       |---\\
      |__| I=[|     .'    '.
      / / ____|     :       '._
     |-/.____.'      | :       :
    /___\ /___\      '-'._----'
"
		# making folders
		echo "\nCreating MERN template..."
		mkdir "$PROJECT_NAME"

		# copying boilerplate
		BOILERPLATE="/Users/jonathankohen/Desktop/code/projects/MERN_boilerplate/"
		TARGET_DIR="/Users/jonathankohen/Desktop/code/projects/$PROJECT_NAME/"
		cd $PROJECT_NAME
		PWD="`pwd`/"

		if [[ $PWD == $TARGET_DIR ]]; then
			cp -r $BOILERPLATE $TARGET_DIR
			echo "\nCopied files ${GREEN}\xE2\x9C\x94${NC}"
		fi

		# customizing .env file, overwriting whatever was in boilerplate
		echo "DB_NAME=${DB_NAME}" > .env
		echo "PORT=${PORT}" >> .env
		echo "SECRET_KEY=${SECRET_KEY}" >> .env
		echo "Customized .env file ${GREEN}\xE2\x9C\x94${NC}"

		# adding README
		echo "# ${PROJECT_NAME}" >> README.md
		echo "Added README ${GREEN}\xE2\x9C\x94${NC}"

		# initializing git
		git init
		echo "Initialized a Git repo ${GREEN}\xE2\x9C\x94${NC}"

		# installing dependencies
		cd server
		npm install
		echo "Installed server-side dependencies ${GREEN}\xE2\x9C\x94${NC}"
		cd ../client
		npm install
		echo "Installed client-side dependencies ${GREEN}\xE2\x9C\x94${NC}"
		cd ..
		echo "${YELLOW}Running the dev server in a moment, hang tight...${NC}"

		sleep 5

		# starting server
		npm run dev
	;;
	
	[nN][oO]|[nN])
		echo "\n${YELLOW}Please re-enter your data.${NC}"
		sh $(basename $0) && exit
	;;

	[eE][xX][iI][tT])
		clear
		echo "
			 Miss you, we will!
		__.-._  _/
		'-._\"7'
		/'.-c
		|  /T
		_)_/LI"

		echo "\n${GREEN}Take care!${NC}\n"
		exit
	;;

	*)
		echo "\n${YELLOW}Invalid input. Please re-enter your data.${NC}"
		sh $(basename $0) && exit
	;;
esac
