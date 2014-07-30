;; standard options
(column-number-mode)
(setq-default fill-column 80)


;; * CEDET
;;(global-ede-mode 1)                     ; Enable the Project management system
(require 'semantic)
(require 'semantic/analyze)
(require 'semantic/sb)
(require 'srecode)

(provide 'semantic-analyze)
(provide 'semantic-ctxt)
(provide 'semanticdb)
(provide 'semanticdb-find)
(provide 'semanticdb-mode)
(provide 'semantic-load)

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

;; * scala mode
(add-to-list 'load-path "~/.emacs.d/scala-mode/src")
(require 'scala-mode-auto)

;; * ruby mode
;;(add-to-list 'load-path "~/.emacs.d/ruby-mode")
;;(require 'ruby-mode)
;;(setq auto-mode-alist  (cons '(".rb$" . ruby-mode) auto-mode-alist))

;; * rst mode
(add-to-list 'load-path "~/.emacs.d/rst-mode")
(require 'rst)

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
