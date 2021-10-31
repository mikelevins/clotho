// the presentation server main process

const { app, crashReporter, BrowserWindow, dialog, ipcMain, Menu } = require('electron');
const process = require('process');
const path = require('path');
const yargs = require('yargs');
const http = require('http');
const fs = require('fs');
const log = require('electron-log');

const clients = new Set();

var HTTPPort = null;
var WSPort = null;

const argv = yargs
      .options({
          'http-port': {
              demandOption: true,
              describe: 'The port on which to connect to the HTTP server.',
              type: 'number'
          },
          'ws-port': {
              demandOption: true,
              describe: 'The port on which to connect to the WebSocket listener.',
              type: 'number'
          }
      })
      .argv;

function createWindow () {
    var httpPort = argv['http-port'];
    var wsPort = argv['ws-port'];
    const win = new BrowserWindow({
        width: 800,
        height: 600,
        webPreferences: {
            nodeIntegration: false, // is default value after Electron v5
            contextIsolation: true, // protect against prototype pollution
            enableRemoteModule: false, // turn off remote
            preload: path.join(__dirname, "js/preload.js") // use a preload script
        }        
    })
    log.info('presenter: main window created');
    win.loadURL('http://127.0.0.1:'+httpPort+'/index.html')
}

app.whenReady().then(() => {
    log.info('presenter ready; creating the window');
    createWindow();
});

app.on('window-all-closed', function () {
    if (process.platform !== 'darwin') app.quit()
})


// handlers for events from the Renderer process

ipcMain.on("quit", (event,data) => {
    log.info('quitting the presenter');
    app.quit();
});

// crashReporter setup
// on an Electron crash

// put crashdumps in clotho/crashdumps
// the path is relative to the directory containing main.js in the built presenter,
// which is clotho/presenter/presenter-<platform>/resources/app/
app.setPath('crashDumps',path.join(__dirname, '../../../../crashdumps/'));
console.log(`Crash dumps directory: ${app.getPath('crashDumps')}`);
crashReporter.start({
  submitURL: "https://example.com",
  uploadToServer: false,
})
