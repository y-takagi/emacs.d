(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown")
  :config
  ;;(setq markdown-command-needs-filename t)
  ;; (add-hook 'markdown-mode-hook
  ;;           '(lambda()
  ;;              (setq markdown-css-paths mkdown-css-file-name)))

  ;; ;; Use orgtbl-mode
  ;; (require 'org-table)
  ;; (defun cleanup-org-tables ()
  ;;   (save-excursion
  ;;     (goto-char (point-min))
  ;;     (while (search-forward "-+-" nil t) (replace-match "-|-"))))
  ;; (add-hook 'markdown-mode-hook 'orgtbl-mode)
  ;; (add-hook 'markdown-mode-hook
  ;;           '(lambda()
  ;;              (add-hook 'before-save-hook 'cleanup-org-tables  nil 'make-it-local)))
  ;; (require 'mmm-mode)
  ;; (setq mmm-global-mode 'maybe)

  ;; (mmm-add-classes
  ;;  '((markdown-ruby
  ;;   :submode ruby-mode
  ;;   :front "^``` ruby[\n\r]+"
  ;;   :back "^```$")))

  ;; (mmm-add-mode-ext-class 'markdown-mode nil 'markdown-ruby)

;;   (require 'mmm-mode)
;;   (setq mmm-global-mode 'maybe)
;;   (setq mmm-parse-when-idle 't)
;;   (defun my-mmm-markdown-auto-class (lang &optional submode)
;;     "Define a mmm-mode class for LANG in `markdown-mode' using SUBMODE.
;; If SUBMODE is not provided, use `LANG-mode' by default."
;;     (let ((class (intern (concat "markdown-" lang)))
;;           (submode (or submode (intern (concat lang "-mode"))))
;;           (front (concat "^```" lang "[\n\r]+"))
;;           (back "^```"))
;;       (mmm-add-classes (list (list class :submode submode :front front :back back)))
;;       (mmm-add-mode-ext-class 'markdown-mode nil class)))

;;   ;; Mode names that derive directly from the language name
;;   (mapc 'my-mmm-markdown-auto-class
;;         '("awk" "bibtex" "c" "cpp" "css" "html" "latex" "lisp" "makefile"
;;           "markdown" "python" "r" "ruby" "sql" "stata" "xml"))
  )
