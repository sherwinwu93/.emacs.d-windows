;; the key to trigger the search ("c")
;; a description of the search for the agenda dispatcher ("Desk Work")
;; the type of search (todo items matching a tag)
;; the tag to search for ("@work")
(setq org-agenda-custom-commands 
      '(
	;; key description searchType searchContent
	("c" "Desk Work" tags-todo "@work" ;; (1) (2) (3) (4)
         ((org-agenda-files '("~/notes/todos/inbox.org")) ;; (5)
          (org-agenda-sorting-strategy '(priority-up effort-down))) ;; (5) cont.
         ("~/computer.html")) ;; (6)
        ;; ...other commands here
        ))
(setq org-agenda-custom-commands
      '(("w" todo "DONE") ;; (1) (2) (3)
	;; ...other commands here
	))
;; A use scenario: block agenda views
(setq org-agenda-custom-commands
      '(("O" "Office block agenda"
         ((agenda "" ((org-agenda-span 1)))
          ;; limits the agenda display to a single day
          (tags-todo "+PRIORITY=\"A\"")
          (tags-todo "@work|@study")
          (tags "@work|@study")
          (tags "@work+CATEGORY=\"elephants\"")
          ;; (tags "review" ((org-agenda-files '("~/notes/todos/circuspeanuts.org"))))
          ;; limits the tag search to the file circuspeanuts.org
          (todo "WAITING"))
         ((org-agenda-compact-blocks t))) ;; options set here apply to the entire block
        ;; ...other commands here
        ))
;; An expamle: GTD weekly review
(setq org-agenda-custom-commands
      '(("W" "Weekly Review"
         ((agenda "" ((org-agenda-span 7))); review upcoming deadlines and appointments
					; type "l" in the agenda to review logged items 
          (stuck "") ; review stuck projects as designated by org-stuck-projects
          (todo "PROJECT") ; review all projects (assuming you use todo keywords to designate projects)
          (todo "MAYBE") ; review someday/maybe items
          (todo "WAITING"))) ; review waiting items
        ;; ...other commands here
        ))

;; different files
(setq org-agenda-custom-commands
      '(("Q" . "Custom queries") ;; gives label to "Q" 
        ("Qa" "Archive search" search ""
         ((org-agenda-files (file-expand-wildcards "~/archive/*.org")))) 
        ("Qw" "Website search" search ""
         ((org-agenda-files (file-expand-wildcards "~/website/*.org"))))
        ("Qb" "Projects and Archive" search ""
         ((org-agenda-text-search-extra-files (file-expand-wildcards "~/archive/*.org"))))
        ;; searches both projects and archive directories
        ("QA" "Archive tags search" org-tags-view "" 
         ((org-agenda-files (file-expand-wildcards "~/archive/*.org"))))
        ;; ...other commands here
        ))
;; using org-agenda-entry-types
(setq org-agenda-custom-commands
      '(("c" "Calendar" agenda ""
         ((org-agenda-span 7)                          ;; [1]
          (org-agenda-start-on-weekday 0)               ;; [2]
          (org-agenda-time-grid nil)                    
          (org-agenda-repeating-timestamp-show-all t)   ;; [3]
          (org-agenda-entry-types '(:timestamp :sexp))))  ;; [4]
	;; other commands go here
        ))
;; with deadline
(setq org-agenda-custom-commands
      '(("d" "Upcoming deadlines" agenda "" 
         ((org-agenda-time-grid nil)
          (org-deadline-warning-days 365)        ;; [1]
          (org-agenda-entry-types '(:deadline))  ;; [2]
          ))
	;; other commands go here
	))

;; GTD contexts
(setq org-agenda-custom-commands
      '(("g" . "GTD contexts")
        ("go" "Office" tags-todo "office")
        ("gc" "Computer" tags-todo "computer")
        ("gp" "Phone" tags-todo "phone")
        ("gh" "Home" tags-todo "home")
        ("ge" "Errands" tags-todo "errands")
        ("G" "GTD Block Agenda"
         ((tags-todo "office")
          (tags-todo "computer")
          (tags-todo "phone")
          (tags-todo "home")
          (tags-todo "errands"))
         nil                      ;; i.e., no local settings
         ("~/next-actions.html")) ;; exports block to this file with C-c a e
	;; ..other commands here
        )
      )
;; Priorities
(setq org-agenda-custom-commands
      '(("p" . "Priorities")
        ("pa" "A items" tags-todo "+PRIORITY=\"A\"")
        ("pb" "B items" tags-todo "+PRIORITY=\"B\"")
        ("pc" "C items" tags-todo "+PRIORITY=\"C\"")
        ;; ...other commands here
        )
      )
;; Calendar style views
(setq org-agenda-custom-commands
      '(("c" "Weekly schedule" agenda ""
         ((org-agenda-span 7)           ;; agenda will start in week view
          (org-agenda-repeating-timestamp-show-all t)   ;; ensures that repeating events appear on all relevant dates
          (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled))))  
        ;; limits agenda view to timestamped items
        ;; ...other commands here
        ))
