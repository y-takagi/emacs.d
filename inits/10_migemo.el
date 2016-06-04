;; (when (and (executable-find "cmigemo")
;;            (require 'migemo nil t))
;;   (setq migemo-command "cmigemo")
;;   (setq migemo-options '("-q" "--emacs"))
;;   (cond ((eq system-type 'gnu/linux)
;;          (setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict"))
;;         ((eq system-type 'darwin)
;;          (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")))
;;   (setq migemo-user-dictionary nil)
;;   (setq migemo-regex-dictionary nil)
;;   (setq migemo-coding-system 'utf-8-unix)
;;   (load-library "migemo")
;;   (migemo-init)

;;   (when (require 'helm-migemo nil t)
;;     ;; この修正が必要
;;     (eval-after-load "helm-migemo"
;;       '(defun helm-compile-source--candidates-in-buffer (source)
;;          (helm-aif (assoc 'candidates-in-buffer source)
;;              (append source
;;                      `((candidates
;;                         . ,(or (cdr it)
;;                                (lambda ()
;;                                  ;; Do not use `source' because other plugins
;;                                  ;; (such as helm-migemo) may change it
;;                                  (helm-candidates-in-buffer (helm-get-current-source)))))
;;                        (volatile) (match identity)))
;;            source))))
;; )
