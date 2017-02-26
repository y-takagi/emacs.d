(use-package undohist
  :config
  (undohist-initialize)

  ;; 永続化を無視するファイル名の正規表現
  (setq undohist-ignored-files
        '("COMMIT_EDITMSG"))
  )
