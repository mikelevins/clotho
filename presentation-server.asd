;;;; presentation-server.asd

;;; enable hunchentoot to function without ssl
(eval-when (:compile-toplevel :load-toplevel :execute)
  (pushnew :HUNCHENTOOT-NO-SSL *features*))


(asdf:defsystem #:presentation-server
  :description "An experimental presentation server for Lisp in Electron"
  :author "mikel evins <mikel@evins.net>"
  :license  "Apache 2.0"
  :version "0.0.2"
  :serial t
  :depends-on (:remote-js)
  :components ((:module "src"
                        :serial t
                        :components ((:file "package")
                                     (:file "presentation-server")))))

#+win32
(defun build-presentation-server ()
  (format t "~%building presentation-server...")
  (let* ((start-time (get-internal-real-time))
         (working-directory (asdf:system-relative-pathname :presentation-server "server/"))
         (build-bat (asdf:system-relative-pathname :presentation-server "server/build.bat")))
    (sb-ext:run-program build-bat () :directory working-directory)
    (format t "~%done in ~S seconds"
            (float (/ (- (get-internal-real-time) start-time)
                      internal-time-units-per-second)))))


#+win32
(defun remove-presentation-server-build ()
  (let ((working-directory (asdf:system-relative-pathname :presentation-server "server/"))
        (clean-bat (asdf:system-relative-pathname :presentation-server "server/clean.bat")))
    (sb-ext:run-program clean-bat () :directory working-directory)))

#+(or nil)(asdf:load-system :presentation-server)
#+(or nil)(build-presentation-server)
#+(or nil)(remove-presentation-server-build)
