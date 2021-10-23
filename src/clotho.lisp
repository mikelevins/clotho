;;;; clotho.lisp

(in-package #:clotho)

(defparameter *http-port* 10102)
(defparameter *websocket-port* 10101)

(defparameter *http-server* (make-instance 'hunchentoot:easy-acceptor :port *http-port*))
(defparameter *presenter* nil)
(defparameter *remote-js-context* nil)

(hunchentoot:define-easy-handler (index :uri "/index.html") ()
  (setf (hunchentoot:content-type*) "text/html")
  (markup:html5
   (:head
    (:meta :charset "utf-8")
    (:meta :http-equiv "X-UA-Compatible" :content "IE=edge")
    (:meta :name "viewport" :content "width=device-width, initial-scale=1"))
   (:body
    (:script (cl-markup:raw (remote-js:js *remote-js-context*))))))

#+darwin
(defun launch-clotho ()
  ;; TODO: use find-port to get an open port, pass it to the Electron process on launch
  (setf *remote-js-context* (remote-js:make-context :port *websocket-port*))
  (hunchentoot:start *http-server*)
  (remote-js:start *remote-js-context*)
  (let* ((exepath "server/clotho-darwin-x64/clotho.app/Contents/MacOS/clotho")
         (server-path (namestring (asdf:system-relative-pathname :clotho exepath))))
    (setf *clotho* (uiop:launch-program server-path))))

#+linux
(defun launch-clotho ()
  ;; TODO: use find-port to get an open port, pass it to the Electron process on launch
  (setf *remote-js-context* (remote-js:make-context :port *websocket-port*))
  (hunchentoot:start *http-server*)
  (remote-js:start *remote-js-context*)
  (let* ((exepath "server/clotho-linux-x64/clotho")
         (server-path (namestring (asdf:system-relative-pathname :clotho exepath))))
    (setf *clotho* (uiop:launch-program server-path))))

#+win32
(defun launch-clotho ()
  ;; TODO: use find-port to get an open port, pass it to the Electron process on launch
  (setf *remote-js-context* (remote-js:make-context :address "127.0.0.1" :port *websocket-port*))
  (hunchentoot:start *http-server*)
  (remote-js:start *remote-js-context*)
  (let* ((exepath "server/clotho-win32-x64/clotho.exe")
         (server-path (namestring (asdf:system-relative-pathname :clotho exepath))))
    (setf *clotho* (uiop:launch-program server-path))))

(defun terminate-clotho ()
  (uiop:terminate-process *clotho* :urgent t))

#+(or nil)(launch-clotho)
#+(or nil)(remote-js:eval *remote-js-context* "alert('hello!')")
#+(or nil)(terminate-clotho)
