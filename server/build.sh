#!/bin/sh

# Package the server app
npm i
npx electron-packager . presentation-server --overwrite
