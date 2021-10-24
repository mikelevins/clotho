;;;; clotho.lisp

(in-package #:clotho)

#+darwin
(defun launch-presenter ()
  ;; TODO: use find-port to get an open port, pass it to the Electron process on launch
  (setf *remote-js-context* (remote-js:make-context :port *websocket-port*))
  (setf *http-server* (make-instance 'hunchentoot:easy-acceptor :port *http-port*))
  (hunchentoot:start *http-server*)
  (remote-js:start *remote-js-context*)
  (let* ((exepath "presenter/presenter-darwin-x64/presenter.app/Contents/MacOS/presenter")
         (presenter-path (namestring (asdf:system-relative-pathname :clotho exepath))))
    (setf *presenter* (uiop:launch-program presenter-path))))

#+linux
(defun launch-presenter ()
  ;; TODO: use find-port to get an open port, pass it to the Electron process on launch
  (setf *remote-js-context* (remote-js:make-context :port *websocket-port*))
  (setf *http-server* (make-instance 'hunchentoot:easy-acceptor :port *http-port*))
  (hunchentoot:start *http-server*)
  (remote-js:start *remote-js-context*)
  (let* ((exepath "presenter/presenter-linux-x64/presenter.exe")
         (presenter-path (namestring (asdf:system-relative-pathname :clotho exepath))))
    (setf *presenter* (uiop:launch-program presenter-path))))

#+win32
(defun launch-presenter ()
  (setf *http-port* (get-available-port))
  (setf *websocket-port* (get-available-port))
  (setf *remote-js-context* (remote-js:make-context :address "127.0.0.1" :port *websocket-port*))
  (setf *http-server* (make-instance 'hunchentoot:easy-acceptor :port *http-port*))
  (hunchentoot:start *http-server*)
  (remote-js:start *remote-js-context*)
  (let* ((exepath "presenter/presenter-win32-x64/presenter.exe")
         (presenter-path (namestring (asdf:system-relative-pathname :clotho exepath)))
         (presenter-string (format nil "~A --http-port ~A --ws-port ~A"
                                   presenter-path *http-port* *websocket-port*)))
    (setf *presenter* (uiop:launch-program presenter-string))))

#+win32
(defun quit-presenter ()
  (remote-js:eval *remote-js-context* "presenter.ipcSend('quit')")
  (hunchentoot:stop *http-server*))

#+(or nil)(launch-presenter)
#+(or nil)(remote-js:eval *remote-js-context* "alert('hello!')")
#+(or nil)(quit-presenter)
