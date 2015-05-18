(use-package search-web
  :disabled t
  :config
  (defun search-web-dwim (&optional arg-engine)
    "transient-mark-mode がオンの時はリージョンを，オフの時はカーソル位置の単語を検索する．"
    (interactive)
    (cond
     (
      (region-active-p)
      (and transient-mark-mode mark-active)
      (search-web-region arg-engine))
     (t
      (search-web-at-point arg-engine))))

  (define-prefix-command 'search-web-map)
  (global-set-key (kbd "M-i") 'search-web-map)
  (global-set-key (kbd "M-i g") (lambda () (interactive) (search-web-dwim "google")))
  (global-set-key (kbd "M-i e") (lambda () (interactive) (search-web-dwim "eijiro")))

  (defadvice eww-render (around eww-render-popwin activate)
    (save-window-excursion ad-do-it)
    (unless (get-buffer-window "*eww*")
      (pop-to-buffer "*eww*")))

  (push "*eww*" popwin:special-display-config)
  )
