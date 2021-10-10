;;;; presentation-server.lisp

(in-package #:presentation-server)

(defparameter *presentation-server* nil)

(defun launch-presentation-server ()
  (let* ((exepath "server/presentation-server-darwin-x64/presentation-server.app/Contents/MacOS/presentation-server")
         (server-path (namestring (asdf:system-relative-pathname :presentation-server exepath))))
    (setf *presentation-server* (uiop:launch-program server-path))))

(defun terminate-presentation-server ()
  (uiop:terminate-process *presentation-server*))

#+(or nil)(launch-presentation-server)
#+(or nil)(terminate-presentation-server)
