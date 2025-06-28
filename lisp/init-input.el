;; 输入法的中文字体
(use-package cnfonts)
;; 输入法的显示框
(use-package posframe)
;; 之后就可以使用它了。
;; 要使用简体中文，记得修改defualt.yml
(use-package rime)
(setq rime-show-candidate 'minibuffer)
;; (setq rime-show-candidate 'message)
;; (setq rime-show-candidate 'popup)
;; (setq rime-show-candidate 'sidewindow)
;; (setq rime-popup-style 'simple)
;; (setq rime-sidewindow-keep-window t)
(setq default-input-method "rime")
(setq rime-user-data-dir "/usr/local/rime")

(provide 'init-input)
