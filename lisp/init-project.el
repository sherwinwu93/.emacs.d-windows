;; ~/.emacs.d/init.el
;; ----------------------------------------project
(use-package projectile
  :ensure t
  :config
  (setq projectile-mode-line "Projectile")
  )

(use-package counsel-projectile
  :ensure t
  :after (projectile)
  :init (counsel-projectile-mode))
;; 忽略文件夹
(setq projectile-globally-ignored-directories '("~/.emacs.d/elpa/"
						"~/.emacs.d/url/"
						"~/.emacs.d/lisp/extensions/"))

;; ----------------------------------------neotree
(use-package neotree)


(provide 'init-project)
