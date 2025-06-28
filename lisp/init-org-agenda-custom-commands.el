;; ----------------------------------------org-agenda-custom-commands
(setq org-agenda-custom-commands
      '(("w" "Wusd block agenda"((tags-todo "+PRIORITY=\"A\"")
				 (agenda "" ((org-agenda-span 1)))
				 (todo "TODO")
				 (todo "WAITING")))
	("p" . "Priorities")
        ("pa" "A items" tags-todo "+PRIORITY=\"A\"")
        ("pb" "B items" tags-todo "+PRIORITY=\"B\"")
        ("pc" "C items" tags-todo "+PRIORITY=\"C\"")
	("W" "Weekly Review" ((agenda "" ((org-agenda-span 7)))
			      (stuck "") 
			      (todo "TODO") 
			      (todo "DOING")
			      (todo "WAITING")))
	("d" "Upcoming deadlines" agenda "" ((org-agenda-time-grid nil)
					     (org-deadline-warning-days 365)        ;; [1]
					     (org-agenda-entry-types '(:deadline))  ;; [2]
					     ))
	("g" . "GTD contexts")
        ("gw" "Work" tags-todo "@work")
        ("gh" "Home" tags-todo "@home")
        ("gb" "Buy" tags-todo "@buy")
        ("gu" "bossurgent" tags-todo "@bossurgent")
        ("gs" "Study" tags-todo "@study")
        ("G" "GTD Block Agenda"
         ((tags-todo "@work")
          (tags-todo "@home")
          (tags-todo "@buy")
          (tags-todo "@bossurgent")
          (tags-todo "@study")))
	))


(provide 'init-org-agenda-custom-commands)
