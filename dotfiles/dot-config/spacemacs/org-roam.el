(with-eval-after-load 'org

    (org-roam-db-autosync-mode)
    (setq org-roam-directory (file-truename "~/org/roam/"))
    (setq org-roam-graph-viewer "firefox-developer-edition")
    (setq org-roam-db-update-on-save t)
    (setq org-download-screenshot-method "flameshot gui --delay 3000 --raw > %s")

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


    )
