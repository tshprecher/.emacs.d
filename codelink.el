;; open browser to supported web ui view of file
(require 'cl)

(setq cl-global-registry-list nil)

;; Opens a link pointing to the line of the current file. If the file is registered
;; under multiple repos, then the first one in the global registry list is used.
;; TODO: handle branch logic
(defun cl-goto-current-position ()
  (interactive)
  (let* ((filename (buffer-file-name (current-buffer)))
         (repo (car
                (delq nil (mapcar (lambda (r)
                                    (if (not (string-prefix-p (cl-repo-dir r) filename))
                                        nil
                                      r))
                                  cl-global-registry-list)))))
    (if (not repo)
        (message "repository not found.")
      (cl-repo-goto-link
       repo
       (substring filename (length (cl-repo-dir repo)))
       (line-number-at-pos)))))

;; abstract repo

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

;; TODO: make line optional
;; TODO: add param for branch
(defmethod cl-repo-goto-link ((repo cl-repo) filename line)
  (browse-url (cl-repo-get-link repo filename line)))

(defmethod cl-repo-get-link ((repo cl-repo) filename line)
  "abstract definition of get-link method")

;; cgit repo
(defclass cl-cgit-repo (cl-repo) ())

(defun cl-make-cgit-repo (name server dir)
  (make-instance 'cl-cgit-repo :name name :server server :dir (expand-file-name dir)))

(defmethod cl-repo-get-link ((repo cl-cgit-repo) filename line)
;; https://cgit.twitter.biz/twitter/tree/config/api/special_clients.yml#n59
  (format
   "https://%s/%s/tree/%s%s"
   (cl-repo-server repo)
   (cl-repo-name repo)
   filename
   (if (not (eq line nil))
       (format "#n%d" line)
     "")))

;; github repo
(defclass cl-github-repo (cl-repo) ())

(defun cl-make-github-repo (name server dir)
  (make-instance 'cl-github-repo :name name :server server :dir (expand-file-name dir)))

(defmethod cl-repo-get-link ((repo cl-github-repo) filename line)
;; https://github.com/twitter/joauth/blob/master/.travis.yml#L3
  (format
   "https://%s/%s/blob/master/%s%s"
   (cl-repo-server repo)
   (cl-repo-name repo)
   filename
   (if (not (eq line nil))
       (format "#L%d" line)
     "")))
