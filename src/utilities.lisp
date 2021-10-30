;;;; clotho.lisp

(in-package #:clotho)

(defun log-message (message-string &rest format-parameters)
  (with-open-file (out *lisp-logfile* :if-does-not-exist :create :if-exists :append
                                      :direction :output)
    (let ((now (format nil "~A" (local-time:now))))
      (if format-parameters
          (format out "[~A] ~A~%" now (apply 'format nil message-string format-parameters))
          (format out "[~A] ~A~%" now message-string)))))

#+nil (log-message "testing logging")
#+nil (log-message "testing logging with args, for example: ~S and ~S" :foo :BAR)
