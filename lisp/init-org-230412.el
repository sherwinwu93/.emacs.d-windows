;; GTD实践方法的配置
;; ----------------------------------------org package
(use-package org
  :config
  (add-hook 'org-mode-hook (lambda() (org-indent-mode -1)
			     (flyspell-mode)
			     (define-key evil-normal-state-map (kbd "<tab>") 'org-cycle)))
  )

;; ----------------------------------------agenda

;; 定义 agenda 文件的位置
(setq org-agenda-files '("/mnt/webdav/org/inbox.org"))

;; 大项目state的hook
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

(setq org-todo-keywords
      '((sequence "TODO(t)"
		  "DOING(g)"
		  "WAITING(b)"
		  "REVIEW(r)"
		  "|"
		  "DONE(d)"
		  )
	))
;; state的颜色
(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
	      ("DONE" :foreground "forest green" :weight bold)
	      ("DOING" :foreground "yellow" :weight bold)
	      ("BLOCKED" :foreground "red" :weight bold)
	      ("REVIEW" :foreground "orange" :weight bold)
	      )))

;; If task state is turned into done, it will  insert "Closed [timestamp]".
(setq org-log-done 'time)

;; Change task state to DOING when clocking in
(setq org-clock-in-switch-to-state "DOING")
;; Change task state to STARTED when clocking in
(setq org-clock-out-switch-to-state "DONE")

;; fast tags
(setq org-tag-alist '(("@work" . ?w)
		      ("@home" . ?h)
		      ("@buy" . ?b)
		      ("@bossurgent" . ?o)
		      ("@ungroup" . ?u)
		      ("@study" . ?s)))

(setq org-refile-targets '(
			   ;;修复bug,不可删除
			   (nil :maxlevel . 1)
			   ("/mnt/webdav/org/inbox.org" :maxlevel . 1)
			   ))
(defun agenda-file()
  (interactive)
  (find-file "/mnt/webdav/org/inbox.org"))

;; ----------------------------------------capture
(setq org-capture-templates '(("c" "Todo [inbox]" entry
			       (file+headline "/mnt/webdav/org/inbox.org" "Tasks")
			       "* TODO %i%?")
			      ("l" "Todo [NCE2]" entry
			       (file+headline "/mnt/webdav/org/inbox.org" "NCE2")
			       "* TODO %i%?")
			      ))

;; ----------------------------------------pomodoro 
;; 通知功能
(defun notify-osx (title message)
  (call-process "terminal-notifier"
		nil 0 nil
		"-group" "Emacs"
		"-title" title
		"-message" message
		;;"-sender" "org.gnu.Emacs"
		"-activate" "oeg.gnu.Emacs"))

;; ----------------------------------------任务提醒功能
;; https://emacs-china.org/t/org-agenda/232
(require 'appt)
(setq appt-time-msg-list nil)    ;; clear existing appt list
(setq appt-display-interval '10)  ;; warn every 5 minutes from t - appt-message-warning-time
(setq
 appt-message-warning-time '20  ;; send first warning 15 minutes before appointment
 appt-display-mode-line nil     ;; don't show in the modeline
 appt-display-format 'window)   ;; pass warnings to the designated window function
(appt-activate 1)                ;; activate appointment notification
(display-time)                   ;; activate time display

(org-agenda-to-appt)             ;; generate the appt list from org agenda files on emacs launch
(run-at-time "24:01" 3600 'org-agenda-to-appt)           ;; update appt list hourly
(add-hook 'org-finalize-agenda-hook 'org-agenda-to-appt) ;; update appt list on agenda view

(defun my-appt-display (min-to-app new-time msg)
  (notify-osx
   (format "Appointment in %s minutes" min-to-app)    ;; passed to -title in terminal-notifier call
   (format "%s" msg)))                                ;; passed to -message in terminal-notifier call
(setq appt-disp-window-function (function my-appt-display))

(require 'init-org-agenda-custom-commands)

;;(provide 'init-org)
