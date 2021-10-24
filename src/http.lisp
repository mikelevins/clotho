;;;; clotho.lisp

(in-package #:clotho)


(hunchentoot:define-easy-handler (index :uri "/index.html") ()
  (setf (hunchentoot:content-type*) "text/html")
  (markup:html5
   (:head
    (:meta :charset "utf-8")
    (:meta :http-equiv "X-UA-Compatible" :content "IE=edge")
    (:meta :name "viewport" :content "width=device-width, initial-scale=1")
    (:title "Clotho"))
   (:body
    (:script (cl-markup:raw (remote-js:js *remote-js-context*))))))

