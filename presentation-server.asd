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

#+(or nil)(asdf:load-system :presentation-server)
