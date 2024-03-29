#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export OASIS_VER='1.16.0'
export UI_VER='1.8.2'

# SETUP AND RUN COMPLEX MODEL EXAMPLE
# Reset compose file to last commit && update tag number 
cd $SCRIPT_DIR
git checkout -- docker-compose.yml
sed -i "s|:latest|:${OASIS_VER}|g" docker-compose.yml

# reset and build custom worker
git checkout -- Dockerfile.custom_model_worker
sed -i "s|:latest|:${OASIS_VER}|g" Dockerfile.custom_model_worker
docker pull coreoasis/model_worker:$OASIS_VER
docker build -f Dockerfile.custom_model_worker -t coreoasis/custom_model_worker:$OASIS_VER .

# Start API
docker-compose down
docker-compose up -d

# RUN OASIS UI
GIT_UI=OasisUI
if [ -d $SCRIPT_DIR/$GIT_UI ]; then
    cd $SCRIPT_DIR/$GIT_UI
    git fetch
    git checkout $UI_VER
else
    git clone https://github.com/OasisLMF/$GIT_UI.git -b $UI_VER
fi 

# Reset UI docker Tag
cd $SCRIPT_DIR/$GIT_UI
git checkout -- docker-compose.yml
sed -i "s|:latest|:${UI_VER}|g" docker-compose.yml
cd $SCRIPT_DIR

# Start UI
docker network create shiny-net
docker pull coreoasis/oasisui_app:$UI_VER
docker-compose -f $SCRIPT_DIR/$GIT_UI/docker-compose.yml up -d

# Run API eveluation notebook
cd $SCRIPT_DIR
docker-compose -f api_evaluation_notebook/docker-compose.api_evaluation_notebook.yml build
docker-compose -f api_evaluation_notebook/docker-compose.api_evaluation_notebook.yml up -d
