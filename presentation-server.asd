;;;; presentation-server.asd

(asdf:defsystem #:presentation-server
  :description "An experimental presentation server for Lisp in Electron"
  :author "mikel evins <mikel@evins.net>"
  :license  "Apache 2.0"
  :version "0.0.1"
  :serial t
  :components ((:module "src"
                        :serial t
                        :components ((:file "package")
                                     (:file "presentation-server")))))

#+(or nil)(asdf:load-system :presentation-server)
