(in-package #:presentation-server)

;;; manually generate the JS for the presentation server's side
#+(or nil)
(progn
  (setf ctx (remote-js:make-context ))
  (remote-js:start ctx)
  (with-open-file (stream (asdf:system-relative-pathname
                           :presentation-server
                           "server/presentation-server-darwin-x64/presentation-server.app/Contents/Resources/app/index.html")
                          :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create)
    (write-string (remote-js:html ctx) stream)))
