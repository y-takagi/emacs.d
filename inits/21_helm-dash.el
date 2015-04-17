(defun ruby-doc ()
  (interactive)
  (setq-local helm-dash-docsets '("Ruby" "Ruby on Rails")))

(add-hook 'ruby-mode-hook 'ruby-doc)
