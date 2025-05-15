(defconst just-packages
    '(just-mode justl))

(defun just/init-just-mode ()
    (use-package just-mode
        :defer t
        :mode ("(?i)justfile\\'" . just-mode))
    :config
    )

(defun just/init-justl ()
    (use-package justl
        :defer t
        :config
        ))
