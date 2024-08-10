;; org-roam
;; (setq org-roam-v2-ack t)


;; I want org-mode docs to be auto-indented
;; (use-package org
;;   :config
;;   (setq org-startup-indented t))

(setq org-roam-directory (file-truename "~/org/roam/"))
(setq org-roam-graph-viewer "firefox-developer-edition")

;; TODO
(defun +org-notes-subdir ()
  "Select notes subdirectory."
  (interactive)
  (let ((dirs (cons "."
                    (seq-map
                     (lambda (p)
                       (string-remove-prefix +org-notes-directory p))
                     (+file-subdirs +org-notes-directory nil t)))))
    (completing-read "Subdir: " dirs nil t))
  )

(setq org-roam-capture-templates
      '(("d" ;; key
         "default" ;; description
         plain ;; type
         (file "~/org/templates/roam-default.template") ;; template
         :if-new (file "${slug}.org") ;; target
         :immediate-finish t
         :unnarrowed t)
        )
      )

(setq org-capture-templates
      '(("p" "Private templates") ;; main menu
        ("pt" ;; keys
         "TODO entry"
         entry
         (file+headline "~/org/private.org" "Capture")
         (file "~/org/templates/todo.txt")
         )
        )
      )

(setq org-download-screenshot-method "flameshot gui --delay 3000 --raw > %s")
