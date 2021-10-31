# Clotho
### _mikel evins <mikel@evins.net>_

Named after the Fate who weaves our destiny, Clotho is an experimental
presentation server for Lisp programs, implemented with Electron.

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

4. Build the presenter application
   cd into the clotho/presenter directory
   If you're on Windows, run npm-install.bat, using CMD
   run the build script (build.sh in bash on macOS and Linux; build.bat in CMD on Windows)

5. Load the Lisp code
   Run SBCL and load clotho.asd
   Eval the following forms:

   (asdf:load-system :clotho) ; to load the system definition

   (clotho::launch-presenter) ; to launch the Clotho presenter app

   (remote-js:eval clotho::*remote-js-context* "alert('hello!')") ; to send some Javascript to the presentation server

   (remote-js:eval *remote-js-context* "presenter.ipcSend('quit')") ; to ask the presenter app to quit

## License

Apache-2.0

