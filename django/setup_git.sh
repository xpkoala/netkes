#!/bin/bash

set -e
set -x
set -o pipefail

MYDIR=$1

pushd $MYDIR/django

if [ ! -d django-postgresql-netfields ]; then
git clone https://github.com/jimfunk/django-postgresql-netfields.git
fi

mkdir -p apps
pushd apps

if [ ! -d blue_management ]; then
git clone https://spideroak.com/dist/blue_management.git
fi

if [ ! -d so_common ]; then
git clone https://spideroak.com/dist/so_common.git
fi

pushd blue_management

git submodule init
git submodule update

#cp -r blue_mgnt/templates/base ../so_common/templates

popd # blue_management
popd #apps

# Setup the static content
mkdir -p static

if [ -e static/blue_common ]; then
    rm static/blue_common
fi
cp -r apps/so_common/static static/

if [ -e apps/blue_management/blue_mgnt/templates/base ]; then
    rm apps/blue_management/blue_mgnt/templates/base
fi

if [ ! -d apps/blue_management/blue_mgnt/templates/base ]; then
cp -r apps/so_common/templates/base apps/blue_management/blue_mgnt/templates
fi

popd # django

