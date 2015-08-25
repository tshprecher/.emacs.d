;; standard options
(column-number-mode)
(line-number-mode)
(setq-default fill-column 80)
(setq-default scroll-step 1)              ; scroll one line at a time
(setq-default indent-tabs-mode nil)       ; turn off tabs
(setq-default cursor-type 'bar)

(add-hook 'write-file-hooks 'delete-trailing-whitespace)

;; TODO: use (provide 'symbol)
(load "~/.emacs.d/hop.el")

;; * CEDET
;;(global-ede-mode 1)                     ; Enable the Project management system
(require 'semantic)
(require 'semantic/analyze)
(require 'semantic/sb)
(require 'srecode)

(load "~/.emacs.d/codelink.el")

;; (provide 'semantic-analyze)
;; (provide 'semantic-ctxt)
;; (provide 'semanticdb)
;; (provide 'semanticdb-find)
;; (provide 'semanticdb-mode)
;; (provide 'semantic-load)

;; Set emacs background colour
;; (set-background-color "red")
;; (set-cursor-color "red")

;; * jdee
(add-to-list 'load-path (format "%s/lisp" "~/.emacs.d/jdee-2.4.1" "Path to JDEE"))
(autoload 'jde-mode "jde" "JDE mode." t)
(setq auto-mode-alist
      (append '(("\\.java\\'" . jde-mode)) auto-mode-alist))

;; * ecb
(add-to-list 'load-path
	     "~/.emacs.d/ecb/ecb-2.40-cedet-wrapper")
(require 'ecb)
(setq stack-trace-on-error t)

(setq ecb-layout-name "left13")
(setq ecb-windows-width 30)
(add-hook 'ecb-activate-hook (lambda () (global-set-key (kbd "C-c d") 'ecb-goto-window-directories)))
(add-hook 'ecb-activate-hook (lambda () (global-set-key (kbd "C-c c") 'ecb-goto-window-edit-last)))
(ecb-activate)
(ecb-byte-compile)

;; * modes
(require 'protobuf-mode)

(add-to-list 'load-path "~/.emacs.d/pig-mode")
(add-to-list 'load-path "~/.emacs.d/protobuf-mode")
;;(add-to-list 'load-path "~/.emacs.d/ruby-mode")
(add-to-list 'load-path "~/.emacs.d/rst-mode")
(add-to-list 'load-path "~/.emacs.d/scala-mode/src")
(add-to-list 'load-path "~/.emacs.d/thrift-mode")

;;(setq auto-mode-alist  (cons '(".rb$" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '("BUILD" . python-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '(".aurora$" . python-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '(".mesos$" . python-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '(".proto$" . protobuf-mode) auto-mode-alist))

(require 'pig-mode)
;;(require 'ruby-mode)
(require 'rst)
(require 'scala-mode-auto)
(require 'thrift-mode)

;; * ediff
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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(ecb-source-path (quote (("~" "~")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; * load local config
(load "~/.local.el")
