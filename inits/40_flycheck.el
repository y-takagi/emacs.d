(use-package flycheck
  :init
  (defun my/use-eslint-from-node-modules ()
    (let* ((root (locate-dominating-file
                  (or (buffer-file-name) default-directory)
                  "node_modules"))
           (eslint (and root
                        (expand-file-name "node_modules/eslint/bin/eslint.js"
                                          root))))
      (when (and eslint (file-executable-p eslint))
        (setq-local flycheck-javascript-eslint-executable eslint))))

  (defun my/use-tslint-from-node-modules ()
    (let* ((root (locate-dominating-file
                  (or (buffer-file-name) default-directory)
                  "node_modules"))
           (tslint (and root
                        (expand-file-name "node_modules/.bin/tslint"
                                          root))))
      (when (and tslint (file-executable-p tslint))
        (setq-local flycheck-typescript-tslint-executable tslint))))

  (defun my/use-sass-lint-from-node-modules ()
    (let* ((root (locate-dominating-file
                  (or (buffer-file-name) default-directory)
                  "node_modules"))
           (sass-lint (and root
                           (expand-file-name "node_modules/.bin/sass-lint"
                                             root))))
      (when (and sass-lint (file-executable-p sass-lint))
        (setq-local flycheck-sass/scss-sass-lint-executable sass-lint))))

  ;; (add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)
  ;; (add-hook 'flycheck-mode-hook #'my/use-tslint-from-node-modules)
  ;; (add-hook 'flycheck-mode-hook #'my/use-sass-lint-from-node-modules)
  (add-hook 'typescript-mode 'flycheck-mode)
  (add-hook 'scss-mode-hook 'flycheck-mode)
  (add-hook 'go-mode-hook 'flycheck-mode)

  ;; elpy
  ;;(remove-hook 'elpy-modules 'elpy-module-flymake)
  ;;(add-hook 'elpy-mode-hook 'flycheck-mode)
  )
