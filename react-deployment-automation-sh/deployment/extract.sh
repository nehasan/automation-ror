#!/usr/bin/env bash

ENV=$1
APP_PATH="/home/deploy/"$2

cd ${APP_PATH}/current
echo "Exracting build.tar.gz to ${APP_PATH}/current directory..."
tar -xzvf build.tar.gz

echo "Cleaning up the build* files..."
mv build/* .
rm -rf build*
