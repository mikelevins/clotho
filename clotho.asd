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
  :depends-on (:remote-js :parenscript :cl-who :local-time)
  :components ((:module "src"
                        :serial t
                        :components ((:file "package")
                                     (:file "parameters")
                                     (:file "utilities")
                                     (:file "http")
                                     (:file "launch")))))

#+(or nil)(asdf:load-system :clotho)
