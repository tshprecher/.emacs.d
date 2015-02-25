;; open browser to supported web ui view of file
(require 'cl)

(setq cl-global-registry-list nil)

;; Opens a link pointing to the line of the current file. If the file is registered
;; under multiple repos, then the first one in the global registry list is used.
;; TODO: handle branch logic

(defun cl-goto-link ()
  (interactive)
  (let* ((filename (buffer-file-name (current-buffer)))
         (repo (car
                (delq nil (mapcar (lambda (r)
                                 (if (not (string-prefix-p (cl-repo-dir r) filename))
                                     nil
                                   r))
                                 cl-global-registry-list)))))
    (if (not repo)
        nil
;; TODO: remove      (list filename (cl-repo-dir repo) (substring filename (length (cl-repo-dir repo)))))))
      (cl-repo-goto-link
       repo
       (substring filename (length (cl-repo-dir repo)))
       (line-number-at-pos)
       nil))))

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

;; TODO: document the last two as optional
(defmethod cl-repo-goto-link (
  (repo cl-repo)
  filename
  line
  branch)

  "abstract definition of goto-link method")

;; cgit repo
(defclass cl-cgit-repo (cl-repo) ())

(defun cl-make-cgit-repo (name server dir)
  (make-instance 'cl-cgit-repo :name name :server server :dir (expand-file-name dir)))

;; TODO: integrate branch
(defmethod cl-repo-goto-link ((repo cl-cgit-repo) filename line branch)
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


(setq twitter-repo (cl-make-cgit-repo "twitter" "cgit.twitter.biz" "~/workspace/twitter"))
(setq test-repo (cl-make-cgit-repo "localemacs" "cgit.local" "~/.emacs.d/"))

;;(cl-cgit-repo-goto-link twitter-repo "config/api/special_clients.yml" 12 nil)
(setq cl-global-registry-list (list test-repo))

(string-prefix-p "/Users/tshprecher/workspace/.emacs.d/" "/Users/tshprecher/.emacs.d/codelink.el")


(cl-goto-link)
;; (expand-file-name "/Applications/Google\\ Chrome.app/Contents/MacOS/")
;; (setq test-reg (cl-make-cgit-registry "name" "hostname" "dirs"))
;; (get-name test-reg)
