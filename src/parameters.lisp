;;;; clotho.lisp

(in-package #:clotho)

(defparameter *http-port* 10102)
(defparameter *websocket-port* 10101)

(defparameter *http-server* nil) ; the Lisp HTTP listener
(defparameter *presenter* nil) ; the Electron presentation server
(defparameter *remote-js-context* nil) ; the Lisp connection to Electron's Javascript evaluator

