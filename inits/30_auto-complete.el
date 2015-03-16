;; auto-complete
(ac-config-default)
;; C-n/C-p で候補を選択
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
;;(add-to-list 'ac-modes 'objc-mode)
;;(global-set-key "\M-/" 'ac-start)
