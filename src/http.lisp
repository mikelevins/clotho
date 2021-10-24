;;;; clotho.lisp

(in-package #:clotho)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (setq cl-who:*attribute-quote-char* #\"))

(hunchentoot:define-easy-handler (index :uri "/index.html") ()
  (setf (hunchentoot:content-type*) "text/html")
  (cl-who:with-html-output-to-string (out nil :prologue t)
    (:html 
     (:head
      (:meta :charset "utf-8")
      (:meta :http-equiv "X-UA-Compatible" :content "IE=edge")
      (:meta :name "viewport" :content "width=device-width, initial-scale=1")
      (:title "Clotho"))
     (:body
      (:script :src "js/htmx.min.js")
      (:script :src "js/fabric.min.js")
      (:script (cl-who:str (remote-js:js *remote-js-context*)))
      (:div
       (:button :hx-get "/clicktest"
                :hx-swap "outerHTML"
                "Test"))
      (:div
       (:canvas :id "drawing-board"
                :width "400" :height "400"
                :style "border:1px solid #000000;"))
      (:div
       (:button :onclick "
var canvas=new fabric.Canvas('drawing-board');
var circle = new fabric.Circle({radius: 20, fill: 'green', left: 100, top: 100}); 
canvas.add(circle);"
                "Draw a Circle"))))
    out))

(hunchentoot:define-easy-handler (clicktest :uri "/clicktest") ()
  (setf (hunchentoot:content-type*) "text/html")
  (cl-who:with-html-output-to-string (out nil :prologue nil)
    (:p "Test succeeded!")
    out))


