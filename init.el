;; *scala mode
(add-to-list 'load-path "~/.emacs.d/scala-mode/src")
(require 'scala-mode-auto)

;; *ruby mode
(add-to-list 'load-path "~/.emacs.d/ruby-mode")
(require 'ruby-mode)
(setq auto-mode-alist  (cons '(".rb$" . ruby-mode) auto-mode-alist))

;; *ediff
(setq ediff-split-window-function 'split-window-horizontally)

(defun ediff-face-settings ()
  (set-face-foreground ediff-current-diff-face-A "blue")
  (set-face-background ediff-current-diff-face-A "red")
  (set-face-foreground ediff-current-diff-face-B "blue")
  (set-face-background ediff-current-diff-face-B "red")

  (set-face-background ediff-even-diff-face-A "red")

;; new lines
  (set-face-background ediff-odd-diff-face-B "medium sea green")
  (set-face-foreground ediff-odd-diff-face-B "black")

;; removed lines
  (set-face-background ediff-odd-diff-face-A "indian red")
  (set-face-foreground ediff-odd-diff-face-A "black")
)

(eval-after-load "ediff"
  `(ediff-face-settings))
