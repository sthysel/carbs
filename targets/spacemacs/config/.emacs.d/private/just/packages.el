(defconst just-packages
    '(just-mode justl))

(defun just/init-just-mode ()
    (use-package just-mode
        :defer t
        :mode (("\\.just\\'" . just-mode)
               ("[Jj]ustfile\\'" . just-mode)
               ("/just\\.d/[^/]+\\'" . just-mode))
        :init
        (progn
          ;; Register just-lsp with lsp-mode
          (with-eval-after-load 'lsp-mode
            (add-to-list 'lsp-language-id-configuration '(just-mode . "just"))
            (lsp-register-client
             (make-lsp-client
              :new-connection (lsp-stdio-connection "just-lsp")
              :major-modes '(just-mode)
              :priority -1
              :server-id 'just-lsp
              :language-id "just"))))
        :config
        (progn
          ;; Enable LSP for just files if lsp layer is enabled
          (when (configuration-layer/layer-used-p 'lsp)
            (add-hook 'just-mode-hook #'lsp)))))

(defun just/init-justl ()
    (use-package justl
        :defer t))
