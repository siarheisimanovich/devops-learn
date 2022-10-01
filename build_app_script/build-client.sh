#!/usr/bin/env bash

# 0. Switch workin directory
cd shop-angular-cloudfront

# 1. Install app deps
npm install
echo "Modules installed"

# 2. Set ENV variable for build configuration
export ENV_CONFIGURATION=production
echo "Set ENV_CONFIGURATION variable"

# 3. Run build
# npm run build -- --configuration $ENV_CONFIGURATION
# NOTE: command result in error
echo "Build created (skipped)"

# 4. Check and remove previous build
app=./dist/client-app.zip
if [ -f $app ]; then 
    rm $app
    echo "Removed previous build"
fi

# 5. Create build archive
if [ ! -d dist ]; then
    mkdir dist
fi
zip ./dist/client-app.zip -r ./src -q
echo "Build archived"
