;; ----------------------------------------其他
(use-package which-key
  :config
  (which-key-mode 1))
;; 关闭按键提示功能
(setq suggest-key-bindings nil)
;; yes no -> y n
(fset 'yes-or-no-p 'y-or-n-p)

;; ----------------------------------------Commmand
;; 显示最新调用的命令
(use-package amx
  :ensure t
  :init (amx-mode 1))
;; 移动到最后并执行代码
(fset 'wusd/eval-last-sexp
      (kmacro-lambda-form [escape ?A ?\C-x ?\C-e escape] 0 "%d"))
(fset 'wusd/ctrl-c-ctrl-c
      (kmacro-lambda-form [?\C-c ?\C-c] 0 "%d"))
;; (defun wusd/ctrl-c-ctrl-c()
;;   (interactive)
;;   (execute-kbd-macro (kbd "C-c C-c")))

;; ----------------------------------------Emacs画面
;; 设置Emacs默认全屏
(setq initial-frame-alist '((fullscreen . maximized)))
;; (set-frame-position (selected-frame) 800 100)
;; (set-frame-width (selected-frame) 110)
;; (set-frame-height (selected-frame) 50)
;; 关闭启动帮助画面
(setq inhibit-splash-screen 1)
(setq initial-scratch-message nil)
;; 关闭工具栏
(tool-bar-mode -1)
;; 关闭菜单栏
(menu-bar-mode -1)
;; 关闭文件滑动控件
(scroll-bar-mode -1)
(use-package dashboard
  :ensure t
  :config
  ;; 个性签名，随读者喜好设置
  (setq dashboard-banner-logo-title "Wusd, welcome to Emacs!")
  ;; 读者可以暂时注释掉这一行，等安装了 projectile 后再使用
  (setq dashboard-projects-backend 'projectile)
  ;; 也可以自定义图片
  (setq dashboard-startup-banner 'official)
  (setq dashboard-items '((recents  . 5)
			                    (projects . 5)
			                    (bookmarks . 10)))
  (setq dashboard-center-content t)
  (setq dashboard-show-shortcuts t)
  (setq dashboard-set-navigator t)
  (dashboard-setup-startup-hook)
  )
(add-hook 'dashboard-mode-hook (lambda() (evil-emacs-state)))
(use-package good-scroll
  :init (good-scroll-mode))

;; ----------------------------------------主题
(use-package spacemacs-dark-theme
  :load-path "~/.emacs.d/lisp/extensions/spacemacs-dark-theme.el"
  :config
  (load-theme 'spacemacs-dark 1))

;; ----------------------------------------启动
;;开启emacs session的保存 
(desktop-save-mode 1)
(defun launch-separate-emacs-in-terminal ()
  (suspend-emacs "fg ; emacs -nw"))
(defun launch-separate-emacs-under-x ()
  (call-process "sh" nil nil nil "-c" "emacs &"))
(defun restart-emacs ()
  (interactive)
  ;; We need the new emacs to be spawned after all kill-emacs-hooks
  ;; have been processed and there is nothing interesting left
  (let ((kill-emacs-hook (append kill-emacs-hook (list (if (display-graphic-p)
                                                           #'launch-separate-emacs-under-x
                                                         #'launch-separate-emacs-in-terminal)))))
    (save-buffers-kill-emacs)))
;; ----------------------------------------Display
;; 光标
(setq-default cursor-type 'bar)
(blink-cursor-mode 1)
;; 高亮当前行
(global-hl-line-mode 1)
;; 显示相对行号
(global-display-line-numbers-mode 1)
(setq-default display-line-numbers-type 'relative)
;; 全部显示图标
(use-package all-the-icons
  :if (display-graphic-p))
;; --------------------modeline
(use-package smart-mode-line
  :ensure t
  :init
  (setq sml/no-confirm-load-theme t)  ; avoid asking when startup
  (sml/setup)
  :config
  (setq rm-blacklist
        (format "^ \\(%s\\)$"
                (mapconcat #'identity
                           '("Projectile.*" "company.*" "Google"
      	                     "Undo-Tree" "counsel" "ivy" "yas" "WK" "Abbrev")
                           "\\|"))))



(provide 'init-better-defaults)
