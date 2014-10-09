;; TODO: rename to linemarker or something like that

(eval-when-compile (require 'cl))
;(require 'highlight-current-line)

(defvar cm-warning-face 'secondary-selection)

(defvar cm-error-face 'trailing-whitespace)

(defvar test-overlay (make-overlay 100 10))
(overlay-put test-overlay 'face 'secondary-selection)

(defstruct cm:actions on-create on-kill)

(defstruct cm:marker data marker actions)

(defun cm:make-marker (data position)
  (let ((m (make-marker)))
    (set-marker m position)
    (make-cm:marker 
     :data data
     :marker m)
    )
  )


;; The ring represents the circular list of markers. It stores 
;; a list of markers and the position of the last marker navigated
;; to by the caller. Callers can navigate to a marker by calling one
;; of the following functions:

;; cm:ring-goto-marker
;; cm:ring-goto-next
;; cm:ring-goto-previous
;; cm:ring-goto-beginning
;; cm:ring-goto-end

(defstruct cm:ring markers-list current-position)

(defun cm:make-ring (markers-list current-position)
  (make-cm:ring 
   :markers-list markers-list
   :current-position current-position)
  )

(defun cm:ring-goto-marker (ring index)
  (let* ((markers-list (cm:ring-markers-list ring))
	 (len (length markers-list))
	 (index (% (+ len index) len))
	 (marker (nth index markers-list)))
    (goto-char (marker-position (cm:marker-marker marker)))
    (move-beginning-of-line nil)
    (setf (cm:ring-current-position ring) index)
    )
  )

(defun cm:ring-goto-next (ring)
  (cm:ring-goto-marker ring (+ (cm:ring-current-position ring) 1))
  )

(defun cm:ring-goto-previous (ring)
  (cm:ring-goto-marker ring (- (cm:ring-current-position ring) 1))
  )

(defun cm:ring-goto-beginning (ring)
  (cm:ring-goto-marker ring 0)
  )

(defun cm:ring-goto-end (ring)
  (cm:ring-goto-marker ring -1)
  )

(defvar test-marker1 (cm:make-marker 'test1 100))
(defvar test-marker2 (cm:make-marker 'test2 150))

(defvar test-ring (cm:make-ring (list test-marker1 test-marker2) 0))

(cm:ring-goto-previous test-ring)


(defun move-point-beginning (datamarker) 
  (beginning-of-buffer)
  )

(defun insert-string ()
  (save-excursion
    (insert "-- on-create works --")
    )
  )

(defun cm:set-line-face (face)
  (lexical-let ( (fce face) )
    (lambda ()
      (save-excursion
	  (put-text-property
	   (line-beginning-position)
	   (line-end-position)
	   'font-lock-face fce)
      ))))

(defun cm:mark-line (data line &optional actions)
  (save-excursion
    (goto-line line)
    (move-beginning-of-line nil)
    (let ((marker (make-cm:marker :data data
		 :marker (point-marker)
		 :actions actions)))
      (progn 
	(funcall (cm:actions-on-create actions))
	marker
	)))
  )

(cm:mark-line "message" 10 (make-cm:actions :on-create (cm:set-line-face 'bold)))

;; sandbox

 (defvar h
   ;; Dummy initialization
   (make-overlay 1 10)
   "Overlay for highlighting.")

;; Set face-property of overlay
 (overlay-put h
	      'face 'menu)

;;   (let ((s "Alex"))
;;       (put-text-property 0 1 'face 'bold)
;;       (insert s))Alex


;; (put-text-property
;;  (line-beginning-position)
;;  (line-end-position)
;;  'font-lock-face 'bold)
