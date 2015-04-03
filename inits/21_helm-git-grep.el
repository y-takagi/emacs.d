;; helm-git
(global-set-key (kbd "C-c g") 'helm-git-grep)
(global-set-key (kbd "C-c p") 'helm-git-grep-at-point)
;; Invoke `helm-git-grep' from isearch.
(define-key isearch-mode-map (kbd "C-c g") 'helm-git-grep-from-isearch)
;; Invoke `helm-git-grep' from other helm.
(eval-after-load 'helm
  '(define-key helm-map (kbd "C-c g") 'helm-git-grep-from-helm))
