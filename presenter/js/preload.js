const { contextBridge, ipcRenderer } = require("electron");

contextBridge.exposeInMainWorld("presenter", {
    ipcSend: (...args) => ipcRenderer.send(...args),

    ipcOn: (key, handler) => ipcRenderer.on(key, (event, ...args) => handler(...args))
});
