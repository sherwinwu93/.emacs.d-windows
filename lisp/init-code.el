;; ----------------------------------------code complete
;; 开启全局Company补全
(use-package company
  :ensure t
  :init (global-company-mode)
  :config
  ;; 只需敲 1 个字母就开始进行自动补全
  (setq company-minimum-prefix-length 1)
  (setq company-tooltip-align-annotations t)
  (setq company-idle-delay 0.0)
  ;; 给选项编号 (按快捷键 M-1、M-2 等等来进行选择).
  (setq company-show-numbers t)
  (setq company-selection-wrap-around t)
  ;; 根据选择的频率进行排序
  (setq company-transformers '(company-sort-by-occurrence)))

;; ----------------------------------------Formatting
;; --------------------indent
(defun indent-buffer()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer()
  (interactive)
  (save-excursion
    (if (region-active-p)
	      (progn
	        (indent-region (region-beginning) (region-end))
	        (message "Indent selected region."))
      (progn
	      (indent-buffer)
	      (message "Indent buffer.")))))
;; --------------------括号
(use-package smartparens
  :config
  ;; 括号展示
  ;; 括号模式
  (show-paren-mode 1)
  (define-advice show-paren-function (:around (fn) fix-show-paren-function)
    "Highlight enclosing parens."
    (cond ((looking-at-p "\\s(") (funcall fn))
	        (t (save-excursion
	             (ignore-errors (backward-up-list))
	             (funcall fn)))))
  ;;设置hook,自动括号匹配
  (add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
  )
(use-package evil-surround
  :config
  ;; 选中区域S(增加括号
  (global-evil-surround-mode))

;; --------------------comment
;;快速注释
(use-package evil-nerd-commenter
  :config
  (evilnc-default-hotkeys t)
  )

;; ----------------------------------------语法检查
;; (use-package flycheck
;;   :ensure t
;;   :init (global-flycheck-mode))


(provide 'init-code)
