(defun init-keymaps-file()
  (interactive)
  (find-file "~/.emacs.d/lisp/init-keymaps.el"))
(setq-default general-non-normal-states '(insert replace hybrid iedit-insert))
(general-create-definer wusd/leader-def
  ;; 表示生效的state
  :states '(normal insert visual emacs motion)
  :keymaps 'override
  ;; states && !general-non-normal-states
  :prefix "SPC"
  ;; states && general-non-normal-states
  ;; :non-normal-prefix ""
  ;; states
  :global-prefix "M-SPC") 

(general-create-definer wusd/local-leader-def
  :states '(normal insert visual emacs motion)
  :prefix ","
  :global-prefix "M-,")


;;; 所有快捷键
;; ------------------------------------------------------------evil
;; 清空evil insert模式的map,使用默认
(setcdr evil-insert-state-map nil)
(general-def :keymaps 'evil-insert-state-map  "<escape>" 'evil-normal-state)
;; ------------------------------------------------------------input
(general-def :keymaps 'rime-active-mode-map  "<tab>" 'rime-inline-ascii)
(general-def :keymaps 'rime-mode-map
  "C-`" 'rime-send-keybinding
  "M-j" 'rime-force-enable)
;; ------------------------------------------------------------better-defaults
;; ----------------------------------------系统级按键
;; C-g键改为CapsLock 由autohotkey实现
;; 改键<menu>为modifier
(define-key key-translation-map (kbd "<menu>") 'event-apply-super-modifier)
(general-def "<escape>" 'minibuffer-keyboard-quit)
;; ----------------------------------------navigation
(general-def :keymaps 'override
  "C-f" 'scroll-up-command
  "C-b" 'scroll-down-command)
(wusd/leader-def
  "jj" 'avy-goto-line
  "jk" 'avy-goto-char-timer
  )
(wusd/leader-def
  "m" 'bookmark-jump)
;; ----------------------------------------Command
(general-def "s-e" 'wusd/eval-last-sexp)
(general-def :keymaps 'override "C-." 'evil-repeat)
;; ----------------------------------------emacs
(wusd/leader-def
  "q" '(:wk "quit")
  "qq" 'save-buffers-kill-terminal
  "qr" 'restart-emacs)

;; ------------------------------------------------------------files
;; ----------------------------------------file
(wusd/leader-def
  "f" '(:wk "file")
  "ff" 'counsel-find-file
  "fs" 'save-buffer
  "fr" 'recentf-open-files
  "fd" (lambda()
         (interactive)
         (find-file "~/notes"))
  "d" 'dired-jump)
;; --------------------dotfile
(wusd/leader-def
  "fe" '(:wk "dotfile")
  "fed" 'init-keymaps-file
  "fea" 'open-abbrev-file
  "fee" 'init-file
  "fer" 'load-init-file)
;; ----------------------------------------buffer
(wusd/leader-def
  "b" '(:wk "buffer")
  "bb" 'switch-to-buffer
  "bk" 'kill-buffer
  "bh" (lambda()
         (interactive)
         (dashboard-open)
         (evil-emacs-state)))
;; ----------------------------------------window
(wusd/leader-def
  "w" '(:wk "window")
  "wo" 'other-window
  "<tab>" 'other-window
  "wd" 'delete-window
  "wm" 'toggle-windows-split
  "we" 'split-window-right-and-focus
  "ws" 'split-window-below-and-focus
  "j" 'scroll-other-window
  "k" 'scroll-other-window-down
  "l" 'recenter-top-bottom
  ;; 配合evil-repeat重复做使用
  "-" 'shrink-window
  "=" 'enlarge-window
  "[" 'shrink-window-horizontally
  "]" 'enlarge-window-horizontally
  "1" 'select-window-1
  "2" 'select-window-2
  "3" 'select-window-3
  "4" 'select-window-4
  "5" 'select-window-5)

;; ------------------------------------------------------------edit
;; ----------------------------------------query and replace
(wusd/leader-def
  "s" '(:wk "search")
  "ss" 'swiper
  "sr" 'query-replace
  "sp" 'counsel-ag)
(general-def
  "s-f"  'swiper
  "s-r" 'query-replace
  "C-S-f" 'counsel-projectile-grep
  "C-S-r" 'projectile-replace)
;; ----------------------------------------CUDA
;;对应Windows上面的Ctrl-a 全选
(general-def
  "s-a" 'mark-whole-buffer
  "s-c" 'kill-ring-save
  "s-v" 'yank
  "s-y" 'yank-pop
  "s-z" 'undo
  "s-x" 'kill-region)
;; ------------------------------------------------------------project
(wusd/leader-def
  "p" '(projectile-command-map :wk "project")
  "ps" 'projectile-grep)
;; ------------------------------------------------------------code
(general-def :keymaps 'override
  "C-M-l" 'indent-region-or-buffer
  "C-/"  'evilnc-comment-or-uncomment-lines)
(wusd/leader-def ";" 'evilnc-comment-or-uncomment-lines)
;; ------------------------------------------------------------macros
(general-def
  "<f5>"  'name-last-kbd-macro
  "<f6>"  'insert-kbd-macro)
;; ------------------------------------------------------------org
;; ----------------------------------------org
(general-def
  )
(general-def :states 'normal  :keymaps 'org-mode-map
  "<tab>" 'org-cycle)
(wusd/leader-def
  "o" 'wusd/org-agenda
  "i" 'org-capture
  "<f10>" 'sync-inbox)

(wusd/local-leader-def :keymaps 'org-mode-map
  "t" 'org-todo
  "," 'org-ctrl-c-ctrl-c
  "e" 'org-insert-structure-template
  "h" 'org-export-dispatch
  "T" 'org-title
  "o" 'org-overview
  "w" 'org-refile
  "ds"  'org-schedule
  "dd"  'org-deadline)


;; ----------------------------------------org-agenda
(general-def :states 'emacs :keymaps 'org-agenda-mode-map
  "j" 'org-agenda-next-line
  "k" 'org-agenda-previous-line
  "gr" 'org-agenda-redo-all
  "gg" 'evil-goto-first-line
  "G" 'evil-goto-line)
(wusd/local-leader-def :keymaps 'org-agenda-mode-map
  "d"  '(:wk "date")
  "ds"  'org-agenda-schedule
  "dd"  'org-agenda-deadline
  "c"  'org-agenda-capture)

;; ------------------------------------------------------------shell
;; ------------------------------------------------------------translate
;; (general-def
;;   "<f7>"  'youdao-dictionary-search-at-point
;;   "<f8>"  'youdao-dictionary-search-at-point+
;;   "s-t" 'wusd/add-pronunciation)
(general-def
  "<f8>"  'wusd/fanyi
  ;; --------------------bing词典 f9,f11增加发音
  "s-t" 'bing-dict-brief
  ;; "<f9>" 'wusd/bing-dict-brief
  "<f10>" 'wusd/add-pronunciation
  "<f11>" 'show-dict-result-in-other-window
  )

;; ------------------------------------------------------------vc
(wusd/leader-def "g" 'magit)
(general-def :states 'emacs :keymaps 'magit-mode-map
  "C-k" 'magit-delete-thing
  "j" 'evil-next-line
  "k" 'evil-previous-line
  "gr" 'magit-refresh
  "gg" 'evil-goto-first-line
  "G" 'evil-goto-line)
(wusd/local-leader-def :keymaps 'with-editor-mode-map
  "," 'with-editor-finish
  "k" 'with-editor-cancel)
;; ------------------------------------------------------------scheme
;; ------------------------------------------------------------help
(define-key key-translation-map (kbd "<SPC>h") (kbd "C-h"))
(general-def
  ;; "<f11>"  'describe-mode
  "<f12>"  'describe-key)
(general-def
  :prefix "C-h"
  "f"  'counsel-describe-function
  "v"  'counsel-describe-variable
  "o"  'counsel-describe-symbol
  "l"  'counsel-find-library)
(provide 'init-keymaps)
