#!/bin/sh

# Package the presenter app
npm i
npx electron-packager . presenter --overwrite
