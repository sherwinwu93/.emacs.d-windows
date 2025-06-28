(use-package awesome-tab
  :load-path "~/.emacs.d/lisp/awesome-tab"
  :config
  (awesome-tab-mode t)
  )
(global-set-key (kbd "M-l")  'awesome-tab-forward-tab)
(global-set-key (kbd "M-h") 'awesome-tab-backward-tab)
(global-set-key (kbd "M-\\") 'awesome-tab-kill-other-buffers-in-current-group)
(setq awesome-tab-height 120)
;; if return t, tab will hide
(defun awesome-tab-hide-tab (x)
  (let ((name (format "%s" x)))
    (or
     (string-equal "*" (substring name 0 1))
     (string-prefix-p "*whick-key*" name)
     (string-prefix-p "*Org tags*" name)
     ;; (string-prefix-p "*helm" name)
     ;; (string-prefix-p "*Help" name)
     ;; (string-prefix-p "*Compile-Log*" name)
     ;; (string-prefix-p "*lsp" name)
     (string-prefix-p "COMMIT_EDITMSG" name)
     (string-prefix-p "magit" name)
     )))

(defun awesome-tab-buffer-groups ()
  (list
   (cond
    ((or (string-equal "*" (substring (buffer-name) 0 1))
         (memq major-mode '(magit-process-mode
                            magit-status-mode
                            magit-diff-mode
                            magit-log-mode
                            magit-file-mode
                            magit-blob-mode
                            magit-blame-mode
                            )))
     "Emacs")
    ((derived-mode-p 'eshell-mode)
     "EShell")
    ;; ((derived-mode-p 'emacs-lisp-mode)
    ;;  "Elisp")
    ;; dired-mode
    ;; ((derived-mode-p 'dired-mode)
    ;;  "Dired")
    ;; ((memq major-mode '(org-mode org-agenda-mode diary-mode))
    ;;  "OrgMode")
    ;; (t
    ;;  (awesome-tab-get-group-name (current-buffer)))
    (t
     "project"))))
;; fixedWidth
;; (setq awesome-tab-label-fixed-length 14)




(provide 'init-tab)
