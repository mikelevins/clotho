# electron-presentation-server
### _mikel evins <mikel@evins.net>_

An experimental presentation server for Lisp programs, implemented with Electron.

## How to build and run it

1. Install SBCL
   http://www.sbcl.org/platform-table.html

2. Install node.js and npm.
   The easiest way is to use nvm:
   https://github.com/nvm-sh/nvm#installing-and-updating

   The current version of this software is developed with:
   nvm v1.1.8
   node.js v14.15.2   

3. Using git, clone this repository

4. Build the presentation-server application
   cd into the server directory in electron-presentation-server
   run the build script (build.sh on macOS and Linux; build.bat on Windows)

5. Load the Lisp code
   Run SBCL and load presentation-server.asd
   Eval the following forms:

   (asdf:load-system :presentation-server) ; to load the system definition
   (presentation-server::launch-presentation-server) ; to launch the presentation-server app
   (remote-js:eval presentation-server::*remote-js-context* "alert('hello!')") ; to send some Javascript to the presentation server

## License

Apache-2.0

