const log = require('electron-log');
const { contextBridge, ipcRenderer } = require("electron");

log.info('exposing presenter API on "presenter"');
contextBridge.exposeInMainWorld("presenter", {
    ipcSend: (...args) => ipcRenderer.send(...args),

    ipcOn: (key, handler) => ipcRenderer.on(key, (event, ...args) => handler(...args))
});
