;; scala mode
(add-to-list 'load-path "~/.emacs.d/scala-mode/src")
(require 'scala-mode-auto)

;; ruby mode
(add-to-list 'load-path "~/.emacs.d/ruby-mode")
(require 'ruby-mode)
(setq auto-mode-alist  (cons '(".rb$" . ruby-mode) auto-mode-alist))

