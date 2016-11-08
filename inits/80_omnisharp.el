(use-package omnisharp
  :disabled t
  :config
  (setq omnisharp-server-executable-path "~/.ghq/github.com/OmniSharp/omnisharp-server/OmniSharp/bin/Debug/OmniSharp.exe")
  (define-key omnisharp-mode-map (kbd "<C-tab>") 'omnisharp-auto-complete)
  (define-key omnisharp-mode-map "." 'omnisharp-add-dot-and-auto-complete)
  )
