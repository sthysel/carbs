(defconst just-packages
    '(just-mode justl))

(defun just/init-just-mode ()
    (use-package just-mode
        :defer t
        :config
        (progn
          ;; Enable LSP for just files if lsp layer is enabled
          (when (configuration-layer/layer-used-p 'lsp)
            (add-hook 'just-mode-hook #'lsp)))))

(defun just/init-justl ()
    (use-package justl
        :defer t
        :config
        ))
