(when (require 'elscreen nil t)
  (elscreen-start)
  (setq elscreen-display-tab nil)
  (define-key global-map (kbd "C-z b") 'helm-elscreen))

(when (require 'elscreen-separate-buffer-list nil t)
  (elscreen-separate-buffer-list-mode 1))
