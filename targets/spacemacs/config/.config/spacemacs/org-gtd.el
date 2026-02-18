;;; org-gtd.el --- GTD-style org-mode configuration -*- lexical-binding: t; -*-
;;
;; Full Getting Things Done workflow with org-mode.
;; Loaded from dotspacemacs/user-config in init.el.
;;
;; Directory layout:
;;   ~/org/
;;   ├── inbox.org           Capture landing pad — process daily
;;   ├── todo.org            Active projects and next actions
;;   ├── someday.org         Someday/maybe items
;;   ├── tickler.org         Deferred/scheduled reminders
;;   ├── journal.org         Daily journal (datetree)
;;   ├── meetings.org        Meeting notes (datetree)
;;   ├── archive.org         Completed/cancelled items
;;   ├── templates/
;;   │   └── roam-default.template
;;   └── roam/
;;       ├── *.org
;;       └── assets/

;;; --- TODO keywords -----------------------------------------------------------

(setq org-todo-keywords
    '((sequence "TODO(t)" "NEXT(n)" "WAITING(w@/!)" "SOMEDAY(s)" "|" "DONE(d!)" "CANCELLED(c@/!)")))

(setq org-todo-keyword-faces
    '(("TODO"      . (:foreground "#cc241d" :weight bold))
      ("NEXT"      . (:foreground "#d79921" :weight bold))
      ("WAITING"   . (:foreground "#d65d0e" :weight bold))
      ("SOMEDAY"   . (:foreground "#83a598" :weight bold))
      ("DONE"      . (:foreground "#98971a" :weight bold))
      ("CANCELLED" . (:foreground "#928374" :weight bold))))

;; Log state changes into LOGBOOK drawer
(setq org-log-into-drawer t)
(setq org-log-done 'time)

;;; --- Files and refile --------------------------------------------------------

(setq org-directory "~/org/")

(setq org-agenda-files
    '("~/org/inbox.org"
      "~/org/todo.org"
      "~/org/tickler.org"))

(setq org-archive-location "~/org/archive.org::datetree/")

;; Refile targets: headings up to 2 levels deep in these files
(setq org-refile-targets
    '(("~/org/todo.org"    :maxlevel . 2)
      ("~/org/someday.org" :maxlevel . 1)
      ("~/org/tickler.org" :maxlevel . 1)))

(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-allow-creating-parent-nodes 'confirm)

;;; --- Tags --------------------------------------------------------------------

(setq org-tag-alist
    '((:startgroup)
      ("@work"  . ?w)
      ("@home"  . ?h)
      ("@errand" . ?e)
      (:endgroup)
      ("phone"  . ?p)
      ("email"  . ?m)
      ("read"   . ?r)
      ("code"   . ?c)))

;;; --- Capture templates -------------------------------------------------------

(setq org-capture-templates
    '(("t" "Todo → inbox" entry
       (file "~/org/inbox.org")
       "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n"
       :empty-lines-after 1)

      ("n" "Next action → inbox" entry
       (file "~/org/inbox.org")
       "* NEXT %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n"
       :empty-lines-after 1)

      ("w" "Waiting for" entry
       (file "~/org/inbox.org")
       "* WAITING %? :@work:\n:PROPERTIES:\n:CREATED: %U\n:END:\n"
       :empty-lines-after 1)

      ("s" "Someday/maybe" entry
       (file "~/org/someday.org")
       "* SOMEDAY %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n"
       :empty-lines-after 1)

      ("T" "Tickler (scheduled)" entry
       (file "~/org/tickler.org")
       "* TODO %?\nSCHEDULED: %^t\n:PROPERTIES:\n:CREATED: %U\n:END:\n"
       :empty-lines-after 1)

      ("j" "Journal" entry
       (file+datetree "~/org/journal.org")
       "* %U %?\n%i"
       :empty-lines-after 1)

      ("m" "Meeting" entry
       (file+datetree "~/org/meetings.org")
       "* %U %? :@work:\n** Attendees\n- \n** Notes\n- \n** Actions\n- [ ] "
       :empty-lines-after 1)))

;;; --- Agenda views ------------------------------------------------------------

(setq org-agenda-custom-commands
    '(("d" "Dashboard"
       ((agenda "" ((org-agenda-span 'day)
                    (org-agenda-overriding-header "Today")))
        (todo "NEXT"
            ((org-agenda-overriding-header "Next Actions")))
        (todo "WAITING"
            ((org-agenda-overriding-header "Waiting On")))
        (tags "REFILE"
            ((org-agenda-overriding-header "To Refile")
             (org-tags-match-list-sublevels nil)))))

      ("w" "Weekly Review"
       ((agenda "" ((org-agenda-span 'week)
                    (org-agenda-overriding-header "This Week")))
        (todo "TODO"
            ((org-agenda-overriding-header "All Active TODOs")))
        (todo "WAITING"
            ((org-agenda-overriding-header "Waiting On")))
        (todo "SOMEDAY"
            ((org-agenda-overriding-header "Someday / Maybe")))))

      ("n" "Next Actions"
       ((todo "NEXT"
            ((org-agenda-overriding-header "All Next Actions")))))

      ("c" "Context"
       ((tags-todo "@work"
            ((org-agenda-overriding-header "Work")))
        (tags-todo "@home"
            ((org-agenda-overriding-header "Home")))
        (tags-todo "@errand"
            ((org-agenda-overriding-header "Errands")))))))

;;; --- Habits ------------------------------------------------------------------

(with-eval-after-load 'org
    (add-to-list 'org-modules 'org-habit)
    (setq org-habit-show-habits-only-for-today t)
    (setq org-habit-graph-column 50))

;;; --- Appearance tweaks -------------------------------------------------------

;; Indent content under headings visually
(setq org-startup-indented t)

;; Show inline images by default
(setq org-startup-with-inline-images t)

;; Priority range A-D, default B
(setq org-priority-highest ?A)
(setq org-priority-lowest ?D)
(setq org-priority-default ?B)

;;; --- org-download (screenshots) ----------------------------------------------

(setq org-download-screenshot-method "grim -g \"$(slurp)\" %s")
(setq org-download-image-dir "~/org/roam/assets/")
(setq org-download-heading-lvl nil)
(setq org-download-timestamp "%Y-%m/%Y%m%d_%H%M%S")

;;; --- screenshot → roam helper ------------------------------------------------

(defvar my/org-roam-screenshot-path nil
    "Path of the last screenshot taken by my/org-roam-screenshot.")

(defun my/org-roam-screenshot ()
    "Create a roam note with an inline screenshot.
Takes a screenshot via grim+slurp, saves it to ~/org/roam/assets/YYYY-MM/,
and creates a new roam note with the image link embedded."
    (interactive)
    (let* ((ts (format-time-string "%Y%m%d_%H%M%S"))
           (subdir (format-time-string "%Y-%m"))
           (dir (expand-file-name subdir "~/org/roam/assets/"))
           (filename (concat ts ".png"))
           (filepath (expand-file-name filename dir)))
        (make-directory dir t)
        (if (= 0 (call-process-shell-command
                   (format "grim -g \"$(slurp)\" %s" (shell-quote-argument filepath))))
            (progn
                (setq my/org-roam-screenshot-path filepath)
                (org-roam-capture- :goto nil :keys "s"))
            (message "Screenshot cancelled."))))

(defun my/org-roam-screenshot-link ()
    "Return org link to the last screenshot, relative to ~/org/roam/."
    (if my/org-roam-screenshot-path
        (let ((rel (file-relative-name my/org-roam-screenshot-path
                                       (expand-file-name "~/org/roam/"))))
            (prog1 (format "[[file:%s]]" rel)
                (setq my/org-roam-screenshot-path nil)))
        ""))

(spacemacs/set-leader-keys "a o s" 'my/org-roam-screenshot)

;;; --- org-roam ----------------------------------------------------------------

(setq org-roam-directory (file-truename "~/org/roam/"))
(setq org-roam-graph-viewer "firefox-developer-edition")
(setq org-roam-db-update-on-save t)
(setq org-roam-capture-templates
    `(("d" "default" plain
       (file "~/org/templates/roam-default.template")
       :if-new (file "${slug}.org")
       :unnarrowed t)
      ("n" "quick note" plain
       (file "~/org/templates/roam-default.template")
       :if-new (file "${slug}.org")
       :immediate-finish t
       :unnarrowed t)
      ("s" "screenshot" plain
       ,(concat "#+title: ${title}\n"
                "#+date: %T\n"
                "#+filetags: :screenshot:%^{Tags}\n\n"
                "%(my/org-roam-screenshot-link)\n\n%?")
       :if-new (file "${slug}.org")
       :unnarrowed t)))

(provide 'org-gtd)
;;; org-gtd.el ends here
