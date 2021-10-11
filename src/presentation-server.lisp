;;;; presentation-server.lisp

(in-package #:presentation-server)

(defparameter *presentation-server* nil)

#+darwin
(defun launch-presentation-server ()
  (let* ((exepath "server/presentation-server-darwin-x64/presentation-server.app/Contents/MacOS/presentation-server")
         (server-path (namestring (asdf:system-relative-pathname :presentation-server exepath))))
    (setf *presentation-server* (uiop:launch-program server-path))))

#+win32
(defun launch-presentation-server ()
  (let* ((exepath "server/presentation-server-win32-x64/presentation-server.exe")
         (server-path (namestring (asdf:system-relative-pathname :presentation-server exepath))))
    (setf *presentation-server* (uiop:launch-program server-path))))

(defun terminate-presentation-server ()
  (uiop:terminate-process *presentation-server* :urgent t))

#+(or nil)(launch-presentation-server)
#+(or nil)(terminate-presentation-server )
