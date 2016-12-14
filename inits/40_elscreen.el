(when (require 'elscreen nil t)
  (elscreen-start)
  (setq elscreen-display-tab nil)
  (define-key global-map (kbd "C-z b") 'helm-elscreen))

(when (require 'elscreen-separate-buffer-list nil t)
  (setq esbl-separate-buffer-list-default '("*dashboard*" "*scratch*" "*Messages*"))
  (elscreen-separate-buffer-list-mode 1))
