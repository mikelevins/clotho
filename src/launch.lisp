;;;; clotho.lisp

(in-package #:clotho)

(defun exepath ()
  #+darwin
  "presenter/presenter-darwin-x64/presenter.app/Contents/MacOS/presenter"
  #+linux
  "presenter/presenter-linux-x64/presenter"
  #+win32
  "presenter/presenter-win32-x64/presenter.exe")

(defun launch-presenter ()
  (let ((document-root-path (asdf:system-relative-pathname :clotho "resources/"))
        (error-template-path (asdf:system-relative-pathname :clotho "resources/errors/")))
    (setf *http-port* (get-available-port))
    (log-message "*http-port* set to ~S" *http-port*)

    (setf *websocket-port* (get-available-port))
    (log-message "*websocket-port* set to ~S" *websocket-port*)

    (setf *remote-js-context* (remote-js:make-context :address "127.0.0.1" :port *websocket-port*))
    (log-message "*remote-js-context* set to ~S" *remote-js-context*)

    (setf *http-server* (make-instance 'hunchentoot:easy-acceptor
                                       :port *http-port*
                                       :document-root document-root-path
                                       :error-template-directory error-template-path))
    (log-message "*http-server* set to ~S" *http-server*)

    (hunchentoot:start *http-server*)
    (log-message "*http-server* started")

    (remote-js:start *remote-js-context*)
    (log-message "remote-js context started")

    (let* ((exepath (exepath))
           (presenter-path (namestring (asdf:system-relative-pathname :clotho exepath)))
           (presenter-string (format nil "~A --http-port ~A --ws-port ~A"
                                     presenter-path *http-port* *websocket-port*)))
      (log-message "starting presenter: ~S" presenter-string)
      (setf *presenter* (uiop:launch-program presenter-string))
      (log-message "presenter started: ~S" (with-output-to-string (out)(describe *presenter* out))))))

(defun quit-presenter ()
  (log-message "sending quit message to presenter")
  (with-simple-restart (continue "Ignore error and continue stopping remaining services.")
    (remote-js:eval *remote-js-context* "presenter.ipcSend('quit')"))
  (log-message "stopping the remote-js context")
  (remote-js:stop *remote-js-context*)
  (log-message "stopping the http server")
  (hunchentoot:stop *http-server*))

#+(or nil)(launch-presenter)
#+(or nil)(remote-js:eval *remote-js-context* "alert('hello!')")
#+(or nil)(quit-presenter)
