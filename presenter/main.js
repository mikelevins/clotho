// the presentation server main process

const { app, BrowserWindow, dialog, ipcMain, Menu } = require('electron');
const path = require('path');

const http = require('http');
const fs = require('fs');

const clients = new Set();

function createWindow () {
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

    // TODO: generate the port number in the server and pass it to Electron on launch
    win.loadURL('http://127.0.0.1:10102/index.html')
}

app.whenReady().then(createWindow)

app.on('window-all-closed', function () {
    if (process.platform !== 'darwin') app.quit()
})


// handlers for events from the Renderer process

ipcMain.on("quit", (event,data) => { app.quit(); });
