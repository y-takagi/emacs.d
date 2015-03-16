;; windowのサイズおよび色設定
(if window-system
    (progn
      (setq initial-frame-alist '((top . 50) (left . 100) (width . 120) (height . 40)))
      (set-background-color "Black")
      (set-foreground-color "LightGray")
      (set-cursor-color "Gray")
      (set-face-background 'fringe "black")
      (set-face-foreground 'fringe "DimGray")
      )
  )
(add-to-list 'default-frame-alist '(alpha . 85))

(scroll-bar-mode 0)
