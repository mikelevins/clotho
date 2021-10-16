// the presentation server main process

const { app, BrowserWindow } = require('electron')

const http = require('http');
const fs = require('fs');

const clients = new Set();

function createWindow () {
  const win = new BrowserWindow({
    width: 800,
    height: 600
  })

  win.loadFile('index.html')
}

app.whenReady().then(createWindow)

app.on('window-all-closed', function () {
  if (process.platform !== 'darwin') app.quit()
})

// for macos: create a new window when activating the app of no windows exist
// app.whenReady().then(() => {
//   createWindow()

//   app.on('activate', function () {
//     if (BrowserWindow.getAllWindows().length === 0) createWindow()
//   })
// })

