;;;; clotho.lisp

(in-package #:clotho)

(defparameter +minimum-port-number+ 32767)
(defparameter +maximum-port-number+ 65535)
(defparameter *ports-already-used* nil)

(defun get-available-port (&key (min +minimum-port-number+) (max +maximum-port-number+))
  (let ((min (if *ports-already-used*
                 (max min (1+ (apply 'max *ports-already-used*)))
                 min)))
    (assert (<= +minimum-port-number+ min +maximum-port-number+)() "Minimum port number is too great; can't find a port")
    (assert (<=  max +maximum-port-number+)() "Maximum port number is too great; can't find a port")
    (assert (<=  min max)() "Minimum port number is greater than maximum port number; can't find a port")
    (let ((found (find-port:find-port :min min :max max)))
      (unless found (error "Didn;t find an available port."))
      (progn (pushnew found *ports-already-used*)
             found))))

#+(or nil)(get-available-port)

(defparameter *http-port* (get-available-port))
(defparameter *websocket-port* (get-available-port))

(defparameter *http-server* nil) ; the Lisp HTTP listener
(defparameter *presenter* nil) ; the Electron presentation server
(defparameter *remote-js-context* nil) ; the Lisp connection to Electron's Javascript evaluator

