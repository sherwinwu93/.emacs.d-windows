;; (use-package youdao-dictionary
;;   :load-path "~/.emacs.d/lisp/extensions"
;;   :init
;;   (setq url-automatic-caching t)
;;   )

;; (fset 'wusd/add-pronunciation
;;    (kmacro-lambda-form [escape ?j ?0 ?v ?e f7 ?  tab ?y ?$ ?  tab ?p] 0 "%d"))

(use-package bing-dict
  :load-path "~/.emacs.d/lisp/extensions"
  :init
  ;; (setq bing-dict-cache-auto-save t)
  )
(defun show-dict-result-in-other-window()
  (interactive)
	(switch-to-buffer-other-window "*wusd*")
  (fundamental-mode)
  (toggle-read-only -1)
  (erase-buffer)
	(insert wusd/dict-result)
  (evil-beginning-of-line)
  (select-window-1))

(fset 'wusd/add-pronunciation
   (kmacro-lambda-form [escape f11 ?0 ?v ?e ?  tab ?v ?E ?E ?h ?y ?  tab ?p ?j ?0] 0 "%d"))
(fset 'wusd/bing-dict-brief
   (kmacro-lambda-form [menu ?t return] 0 "%d"))


(use-package sdcv
  :load-path "~/.emacs.d/lisp/extensions"
  :init
  ;; (setq bing-dict-cache-auto-save t)
  )
;;say word after translation
;; (setq sdcv-say-word-p t)
;;setup directory of stardict dictionary
(setq sdcv-dictionary-data-dir "/root/sdcv")
;;setup dictionary list for simple search
(setq sdcv-dictionary-simple-list
      '(
        ))
;;setup dictionary list for complete search
(setq sdcv-dictionary-complete-list     
      '(
        "Longman Dictionary of Contemporary English 5th Ed. (En-En)"
        ))

(defun copy-buffer-to-buffer (source-buffer target-buffer)
  "Copy the entire content of SOURCE-BUFFER to TARGET-BUFFER."
  (interactive "bSource buffer: \nbTarget buffer: ")
  (with-current-buffer source-buffer
    (setq copied-text (buffer-substring-no-properties (point-min) (point-max))))
  (with-current-buffer target-buffer
    (goto-char (point-max))
    (insert copied-text)))

(defun delete-matched-filenames ()
  (interactive)
  (switch-to-buffer "*wusd*")
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "\\([a-zA-Z0-9]+\\)_\\([a-zA-Z0-9_-]+\\)\\.wav" nil t)
      (replace-match "")))
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "\"\\(BrE\\|AmE\\|NAmE\\)\"" nil t)
      (replace-match ""))))

(defun wusd/fanyi()
  (interactive)
  (sdcv-search-pointer)
	(switch-to-buffer "*wusd*")
  (fundamental-mode)
  (toggle-read-only -1)
  (erase-buffer)
	(switch-to-buffer "*SDCV*")
  (copy-buffer-to-buffer "*SDCV*" "*wusd*")
	(switch-to-buffer "*wusd*")
  (delete-matched-filenames)
  (sdcv-mode)
  (select-window-1)
  )

(provide 'init-translate)





