;; open browser to supported web ui view of file
(require 'cl)

(setq cl-browser-bin "/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome")

(defvar cl-browser-bin2 "/Applications")

;; (shell-command (concat "ls" "\\" cl-browser-bin))

(let ((process-connection-type nil))  ; use a pipe
  (start-process "my-process2" "foo" "ls" "-l" "/bin"))

(defun cl-browser-open (url)
  (shell-command (concat cl-browser-bin " " url "& disown")))


;; ***** ABSTRACT REPO REGISTRY *****
  (defclass my-baseclass ()
        ((slot-A :initarg :slot-A)
         (slot-B :initarg :slot-B))
       "My Baseclass.")


(defclass cl-registry ()
  ((name
    :initarg   :name
    :accessor  get-name)

   (server  :initarg :server)
   (dirs    :initarg :dirs))
  "Abstract codelink registry")

;; TODO document the last two as optional
(defmethod cl-registry-goto-link (filename line branch)
  nil)

;; **********************************

;; ***** CGIT REGISTRY **************

(defclass cl-cgit-registry (cl-registry) ())

(defun cl-make-cgit-registry (name server dirs)
  (make-instance 'cl-cgit-registry :name name :server server :dirs dirs))

(defmethod cl-cgit-registry-goto-link (filename line branch)
  (cl-browser-open "www.testing.com")) ;; TODO: fix dummy endpoint for now

(setq test-reg (cl-make-cgit-registry "name" "hostnam" "dirs"))

(get-name test-reg)
