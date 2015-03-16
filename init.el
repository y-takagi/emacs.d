;; cask setting
(require 'cask "~/.cask/cask.el")
(cask-initialize)

;; use pallet
(pallet-mode t)

;; init-loader setting
(setq init-loader-show-log-after-init 'error-only)
(init-loader-load "~/.emacs.d/inits")
