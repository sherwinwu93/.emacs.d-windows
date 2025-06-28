;;(package-initialize)
;; 递归遍历加载路径
(defun add-subdirs-to-load-path(dir)
  "Recursive add directories to `load-path`"
  (let ((default-directory (file-name-as-directory dir)))
    (add-to-list 'load-path dir)
    (normal-top-level-add-subdirs-to-load-path)))

(add-subdirs-to-load-path "~/.emacs.d/lisp/")
(defun init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(defun init-dirs()
  (interactive)
  (find-file "~/.emacs.d/lisp"))

(defun load-init-file()
  (interactive)
  (load-file "~/.emacs.d/init.el"))
;; ----------------------------------------包管理和evil放最上面
(require 'init-packages)
(require 'init-evil)
(require 'init-input)
;; ----------------------------------------
(require 'init-better-defaults)
(require 'init-files)
(require 'init-edit)
;;(require 'init-tab)
(require 'init-project)
;; ----------------------------------------
(require 'init-code)
(require 'init-org)
;; (require 'init-shell)
;; ----------------------------------------
;; (require 'init-translate)
(require 'init-vc)
;; (require 'init-scheme)
;; ----------------------------------------快捷键放最后
(require 'my-mode)
(require 'init-keymaps)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default))
 '(package-selected-packages
   '(fanyi toc-org perspective spaceline spaceline-config general appt youdao-dictionary window-numbering which-key use-package undo-tree smartparens smart-tabs-mode smart-tab smart-mode-line rime popwin org-pomodoro org neotree magit good-scroll exec-path-from-shell evil-surround evil-nerd-commenter evil-leader dashboard counsel-projectile company cnfonts cal-china-x avy amx))
 '(warning-suppress-types '((magit))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 110 :width normal)))))

