(use-package xscheme
  :load-path "~/.emacs.d/lisp/extensions/x-scheme.el"
  :init (setq scheme-program-name "/usr/local/bin/mit-scheme --stack 10000")
  )

(defun open-mit-scheme()
  (interactive)
  (execute-kbd-macro (kbd "C-x 2"))
  (execute-kbd-macro (kbd "C-x o"))
  (run-scheme "scheme --heap 512")
  (execute-kbd-macro (kbd "C-x o"))
)



(provide 'init-scheme)
