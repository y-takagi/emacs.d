;; cask setting
(require 'cask "~/.cask/cask.el")
(cask-initialize)

;; use pallet
(pallet-mode t)

;; use-package option
(unless (require 'use-package nil t)
  (defmacro use-package (&rest args)))

;; init-loader setting
(setq init-loader-show-log-after-init 'error-only)
(init-loader-load "~/.emacs.d/inits")
