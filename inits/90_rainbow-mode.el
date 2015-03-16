;; rainbow-mode
(add-hook 'scss-mode-hook 'rainbow-mode)
(add-hook 'slim-mode-hook 'rainbow-mode)
(add-hook 'rhtml-mode-hook 'rainbow-mode)

(custom-set-variables
 '(rainbow-html-colors-major-mode-list (quote (scss-mode html-mode css-mode php-mode nxml-mode xml-mode))))
