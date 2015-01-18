;; Navigate quickly to a line within the window in exponentially increasing hops.
;;
;; Author: Tal Shprecher
;; Email:  tshprecher@gmail.com

(defun hop-get-current-exec-state () (point))
(defun hop-set-current-exec-state () (setq hop-last-exec-state (point)))
(defun hop-exec-state-equal (first second) (equal first second))

(defun hop-init ()
  (interactive)
  (setq hop-lower-bound (- (line-number-at-pos (window-end)) 1))
  (setq hop-upper-bound (line-number-at-pos (window-start)))
  (setq hop-start-inc 2)
  (setq hop-lower-inc hop-start-inc)
  (setq hop-upper-inc hop-start-inc)
  (setq hop-last-exec-state (hop-get-current-exec-state)))

(defun hop-init-exec-state ()
  (interactive)
  (if (hop-exec-state-equal hop-last-exec-state (hop-get-current-exec-state))
    nil
    (hop-init)))

(defun hop-up ()
  (interactive)
  (hop-init-exec-state)
  (let ((current-line (line-number-at-pos (point))))
    (progn
      (if (< (- current-line hop-upper-inc) hop-upper-bound)
          (goto-line hop-upper-bound)
        (progn
         (if (= (- current-line hop-upper-inc) hop-upper-bound)
            (goto-line (- current-line 1))
            (goto-line (- current-line hop-upper-inc)))))
      (setq hop-lower-bound current-line)
      (setq hop-lower-inc 2)
      (setq hop-upper-inc (* 2 hop-upper-inc))))
  (hop-set-current-exec-state))

(defun hop-down ()
  (interactive)
  (hop-init-exec-state)
  (let ((current-line (line-number-at-pos (point))))
    (progn
      (if (> (+ current-line hop-lower-inc) hop-lower-bound)
          (goto-line hop-lower-bound)
        (progn
          (if (= (+ current-line hop-lower-inc) hop-lower-bound)
            (goto-line (+ current-line 1))
            (goto-line (+ current-line hop-lower-inc)))))
      (setq hop-upper-bound current-line)
      (setq hop-upper-inc 2)
      (setq hop-lower-inc (* 2 hop-lower-inc))))
  (hop-set-current-exec-state))

;; key bindings
(global-set-key (kbd "C-u") 'hop-up)
(global-set-key (kbd "C-j") 'hop-down)

(hop-init)
