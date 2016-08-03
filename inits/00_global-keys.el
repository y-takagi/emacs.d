;; copy & paste
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-w" 'clipboard-kill-region)

(global-set-key "\C-cc" 'comment-or-uncomment-region)
(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\C-x\C-i" 'indent-region)
(global-set-key "\C-x\C-c" 'helm-M-x)
(global-set-key [C-tab] 'indent-for-tab-command)

(global-unset-key "\C-x\C-z")
(global-unset-key "\C-o")


