(use-package helm-git-grep
  :bind (("C-c g" . helm-git-grep)
         ("C-c p" . helm-git-grep-at-point))
  :config
  ;; Invoke `helm-git-grep' from isearch.
  (define-key isearch-mode-map (kbd "C-c g") 'helm-git-grep-from-isearch)
  ;; Invoke `helm-git-grep' from other helm.
  (eval-after-load 'helm
    '(define-key helm-map (kbd "C-c g") 'helm-git-grep-from-helm))
  )
