#! /bin/bash

ENV=$1
SERVER=""
APP_PATH="apps/shopoth_ecom_v2_${ENV}"
GIT_BRANCH=""

deploy(){
  git pull origin ${GIT_BRANCH}
  tar --exclude='./.git' --exclude='./node_modules' -czvf mk.tar.gz .
  ssh deploy@${SERVER} "cd ${APP_PATH} && rm -rf *"
  scp mk.tar.gz deploy@${SERVER}:${APP_PATH}/
  ssh deploy@${SERVER} "cd ${APP_PATH} && tar -xzvf mk.tar.gz"
  ssh deploy@${SERVER} "cd ${APP_PATH} && rm mk.tar.gz"
  ssh deploy@${SERVER} "cd ${APP_PATH} && yarn install && yarn build"
  ssh deploy@${SERVER} ". ${APP_PATH}/deployment/restart-node.sh ${ENV}"
  rm mk.tar.gz
}

if [[ "production" = $ENV ]];then
  printf "\n\n\n"
  GIT_BRANCH="master"
  SERVER="<server_ip_address : 54.xxx.xxxx.xxx>"
	echo "v2 deploying to production server : ${SERVER} ..."
  # release
  # deploy
elif [[ "pre_prod" = $ENV ]]; then
  printf "\n\n\n"
  GIT_BRANCH="pre-production"
  SERVER="<server_ip_address : 54.xxx.xxxx.xxx>"
  echo "v2 deploying to pre_prod server : ${SERVER} ..."
  # release
  deploy
elif [[ "staging" = $ENV ]]; then
  printf "\n\n\n"
  SERVER="<server_ip_address : 54.xxx.xxxx.xxx>"
  GIT_BRANCH="development"
	echo "v2 deploying to staging server : ${SERVER} ..."
  # release
  deploy
else
	echo "Please specify environment as argument!"
fi
