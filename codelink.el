;; open browser to supported web ui view of file
(require 'cl)

;; ***** ABSTRACT REPO *****

(defclass cl-repo ()
  ((name
    :initarg   :name
    :accessor  cl-repo-name)

   (server
    :initarg   :server
    :accessor  cl-repo-server)

   (dir
    :initarg   :dir
    :accessor  cl-repo-dir))

  "abstract repo registry")

;; TODO: document the last two as optional
(defmethod cl-repo-goto-link (
  (repo cl-repo)
  filename
  line
  branch)

  "abstract definition of goto-link method")

;; **********************************

;; ********* CGIT REPO ************

(defclass cl-cgit-repo (cl-repo) ())

(defun cl-make-cgit-repo (name server dir)
  (make-instance 'cl-cgit-repo :name name :server server :dir (expand-file-name dir)))


;; TODO: integrate branch
(defmethod cl-cgit-repo-goto-link ((repo cl-cgit-repo) filename line branch)
;; https://cgit.twitter.biz/twitter/tree/config/api/special_clients.yml#n59
  (browse-url
   (format
    "https://%s/%s/tree/%s%s"
    (cl-repo-server repo)
    (cl-repo-name repo)
    filename
    (if (not (eq line nil))
        (format "#n%d" line)
      ""))))

;; debugging zone

(expand-file-name "/Applications/Google\\ Chrome.app/Contents/MacOS/")
(setq twitter-repo (cl-make-cgit-repo "twitter" "cgit.twitter.biz" "~/workspace/twitter"))
(cl-cgit-repo-goto-link twitter-repo "config/api/special_clients.yml" 12 nil)

;; (expand-file-name "~")
;; (setq test-reg (cl-make-cgit-registry "name" "hostname" "dirs"))
;; (get-name test-reg)
