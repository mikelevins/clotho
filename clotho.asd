;;;; clotho.asd

;;; enable hunchentoot to function without ssl
(eval-when (:compile-toplevel :load-toplevel :execute)
  (pushnew :HUNCHENTOOT-NO-SSL *features*))


(asdf:defsystem #:clotho
  :description "An experimental presentation server for Lisp built with Electron"
  :author "mikel evins <mikel@evins.net>"
  :license  "Apache 2.0"
  :version "0.0.2"
  :serial t
  :depends-on (:remote-js)
  :components ((:module "src"
                        :serial t
                        :components ((:file "package")
                                     (:file "clotho")))))

#+(or darwin linux)
(defun build-clotho ()
  (format t "~%building clotho...")
  (let* ((start-time (get-internal-real-time))
         (working-directory (asdf:system-relative-pathname :clotho "server/"))
         (build-sh (asdf:system-relative-pathname :clotho "server/build.sh")))
    (sb-ext:run-program build-sh () :directory working-directory)
    (format t "~%done in ~S seconds"
            (float (/ (- (get-internal-real-time) start-time)
                      internal-time-units-per-second)))))

#+win32
(defun build-clotho ()
  (format t "~%building clotho...")
  (let* ((start-time (get-internal-real-time))
         (working-directory (asdf:system-relative-pathname :clotho "server/"))
         (build-bat (asdf:system-relative-pathname :clotho "server/build.bat")))
    (sb-ext:run-program build-bat () :directory working-directory)
    (format t "~%done in ~S seconds"
            (float (/ (- (get-internal-real-time) start-time)
                      internal-time-units-per-second)))))


#+(or darwin linux)
(defun remove-clotho-build ()
  (let ((working-directory (asdf:system-relative-pathname :clotho "server/"))
        (clean-sh (asdf:system-relative-pathname :clotho "server/clean.sh")))
    (sb-ext:run-program clean-sh () :directory working-directory)))


#+win32
(defun remove-clotho-build ()
  (let ((working-directory (asdf:system-relative-pathname :clotho "server/"))
        (clean-bat (asdf:system-relative-pathname :clotho "server/clean.bat")))
    (sb-ext:run-program clean-bat () :directory working-directory)))


#+(or nil)(asdf:load-system :clotho)
#+(or nil)(build-clotho)
#+(or nil)(remove-clotho-build)
