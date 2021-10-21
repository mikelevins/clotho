;;;; presentation-server.lisp

(in-package #:presentation-server)

(defparameter *http-port* 10102)
(defparameter *websocket-port* 10101)

(defparameter *presentation-server* (make-instance 'hunchentoot:easy-acceptor :port *http-port*))
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
(defun launch-presentation-server ()
  ;; TODO: use find-port to get an open port, pass it to the Electron process on launch
  (setf *remote-js-context* (remote-js:make-context :port *websocket-port*))
  (hunchentoot:start *presentation-server*)
  (remote-js:start *remote-js-context*)
  (let* ((exepath "server/presentation-server-darwin-x64/presentation-server.app/Contents/MacOS/presentation-server")
         (server-path (namestring (asdf:system-relative-pathname :presentation-server exepath))))
    (setf *presentation-server* (uiop:launch-program server-path))))

#+linux
(defun launch-presentation-server ()
  ;; TODO: use find-port to get an open port, pass it to the Electron process on launch
  (setf *remote-js-context* (remote-js:make-context :port *websocket-port*))
  (hunchentoot:start *presentation-server*)
  (remote-js:start *remote-js-context*)
  (let* ((exepath "server/presentation-server-linux-x64/presentation-server")
         (server-path (namestring (asdf:system-relative-pathname :presentation-server exepath))))
    (setf *presentation-server* (uiop:launch-program server-path))))

#+win32
(defun launch-presentation-server ()
  ;; TODO: use find-port to get an open port, pass it to the Electron process on launch
  (setf *remote-js-context* (remote-js:make-context :address "127.0.0.1" :port *websocket-port*))
  (hunchentoot:start *presentation-server*)
  (remote-js:start *remote-js-context*)
  (let* ((exepath "server/presentation-server-win32-x64/presentation-server.exe")
         (server-path (namestring (asdf:system-relative-pathname :presentation-server exepath))))
    (setf *presentation-server* (uiop:launch-program server-path))))

(defun terminate-presentation-server ()
  (uiop:terminate-process *presentation-server* :urgent t))

#+(or nil)(launch-presentation-server)
#+(or nil)(remote-js:eval *remote-js-context* "alert('hello!')")
#+(or nil)(terminate-presentation-server)
