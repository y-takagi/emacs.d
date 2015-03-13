;; helm
(require 'helm)
(require 'helm-files)
(require 'helm-ag)
(global-set-key (kbd "M-g .") 'helm-ag)
(global-set-key (kbd "M-g ,") 'helm-ag-pop-stack)
(global-set-key (kbd "C-M-s") 'helm-ag-this-file)

;; helm-git
(global-set-key (kbd "C-c g") 'helm-git-grep)
;; Invoke `helm-git-grep' from isearch.
(define-key isearch-mode-map (kbd "C-c g") 'helm-git-grep-from-isearch)
;; Invoke `helm-git-grep' from other helm.
(eval-after-load 'helm
  '(define-key helm-map (kbd "C-c g") 'helm-git-grep-from-helm))

(when (require 'helm-config nil t)
  (helm-mode 1)

  (define-key global-map (kbd "M-x")     'helm-M-x)
  (define-key global-map (kbd "C-x C-f") 'helm-find-files)
  (define-key global-map (kbd "C-x C-r") 'helm-recentf)
  (define-key global-map (kbd "M-y")     'helm-show-kill-ring)
  (define-key global-map (kbd "C-c i")   'helm-imenu)
  (define-key global-map (kbd "C-x b")   'helm-buffers-list)

  (define-key helm-map (kbd "C-h") 'delete-backward-char)
  (define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
  (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
  (define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

  ;; Disable helm in some functions
  (add-to-list 'helm-completing-read-handlers-alist '(find-alternate-file . nil))

  ;; Emulate `kill-line' in helm minibuffer
  (setq helm-delete-minibuffer-contents-from-point t)
  (defadvice helm-delete-minibuffer-contents (before helm-emulate-kill-line activate)
    "Emulate `kill-line' in helm minibuffer"
    (kill-new (buffer-substring (point) (field-end))))

  (defadvice helm-ff-kill-or-find-buffer-fname (around execute-only-if-exist activate)
    "Execute command only if CANDIDATE exists"
    (when (file-exists-p candidate)
      ad-do-it))

  (defadvice helm-ff-transform-fname-for-completion (around my-transform activate)
    "Transform the pattern to reflect my intention"
    (let* ((pattern (ad-get-arg 0))
           (input-pattern (file-name-nondirectory pattern))
           (dirname (file-name-directory pattern)))
      (setq input-pattern (replace-regexp-in-string "\\." "\\\\." input-pattern))
      (setq ad-return-value
            (concat dirname
                    (if (string-match "^\\^" input-pattern)
                        ;; '^' is a pattern for basename
                        ;; and not required because the directory name is prepended
                        (substring input-pattern 1)
                      (concat ".*" input-pattern)))))))

;; auto-complete
(require 'auto-complete-config)
(ac-config-default)
;; C-n/C-p で候補を選択
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
;;(add-to-list 'ac-modes 'objc-mode)
;;(global-set-key "\M-/" 'ac-start)

;;(add-to-list 'auto-mode-alist '("\\.rabl$" . ruby-mode)) ;; rabl-mode
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode)) ;; rake-mode
(add-to-list 'auto-mode-alist '("\\.jbuilder$" . ruby-mode)) ;; jbuilder-mode
(add-to-list 'auto-mode-alist '("\\.builder$" . ruby-mode)) ;; builder-mode

;; ruby-end
(require 'ruby-end)

;; slim-mode
(require 'slim-mode)

;; scss-mode
(require 'scss-mode)

;; yaml-mode
(require 'yaml-mode)

;; rhtml-mode
(require 'rhtml-mode)

;; rainbow-mode
(require 'rainbow-mode)
(add-hook 'scss-mode-hook 'rainbow-mode)
(add-hook 'slim-mode-hook 'rainbow-mode)
(add-hook 'rhtml-mode-hook 'rainbow-mode)

;; coffee-mode
;;(require 'coffee-mode)
;;(defun coffee-custom ()
;;  "coffee-mode-hook"
;;  (set (make-local-variable 'tab-width) 2)
;;  (setq coffee-tab-width 2))
;;(add-hook 'coffee-mode-hook
;;    '(lambda() (coffee-custom)))

;; csv-mode
;;(require 'csv-mode)

;; Dart
;;(require 'dart-mode)

;; Erlang-mode
;;(require 'erlang-start)
;;(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; '(custom-enabled-themes nil))
;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; )

;; C# mode
;; (autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
;; (setq auto-mode-alist (cons '("\\.cs$" . csharp-mode) auto-mode-alist))

;; Paredit
;; (defun turn-on-paredit () (paredit-mode 1))
;; (add-hook 'clojure-mode-hook 'turn-on-paredit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; elisp setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; add elisp to load path
;;(let ((default-directory (expand-file-name "~/.emacs.d/elisp")))
;;  (add-to-list 'load-path default-directory)
;;  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
;;      (normal-top-level-add-subdirs-to-load-path)))

;; color
;; $ cd
;; $ curl -O http://gnuemacscolorthemetest.googlecode.com/files/color-theme-6.6.0-mav.zip
;; $ unzip color-theme-6.6.0-mav.zip
;; $ mv color-theme-6.6.0/themes color-theme-6.6.0/color-theme.el .emacs.d/elisp
;;(require 'color-theme)
;;(color-theme-initialize)
;;(color-theme-dark-laptop)

;; renpy-mode
;; (require 'renpy)

;; ;; json.el
;; (require 'json)

;; color-moccur
;;(require 'color-moccur)

;; js2-mode
;; (autoload 'js2-mode "js2-mode" nil t)
;; (add-to-list 'auto-mode-alist '("\\.\\(js\\|json\\)$" . js2-mode))

;; ;; markdown-mode
;; (autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
;; (setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; reST
;; (require 'rst)
;; (setq auto-mode-alist
;;       (append '(("\\.rst$" . rst-mode)
;;                 ("\\.rst$" . rst-mode)) auto-mode-alist))
;; (setq frame-background-mode 'dark)
;; (add-hook 'rst-mode-hook '(lambda() (setq indent-tabs-mode nil)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-html-colors-major-mode-list (quote (scss-mode html-mode css-mode php-mode nxml-mode xml-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
