;; Configuration for just layer

;; Ensure .just files are recognized by just-mode
(add-to-list 'auto-mode-alist '("\\.just\\'" . just-mode))
(add-to-list 'auto-mode-alist '("[Jj]ustfile\\'" . just-mode))
;; Files in just.d directories (e.g., settings.just in ~/.config/just/just.d/)
(add-to-list 'auto-mode-alist '("/just\\.d/[^/]+\\'" . just-mode))

;; Register just-lsp server with lsp-mode
(with-eval-after-load 'lsp-mode
  ;; Register language ID for just-mode
  (add-to-list 'lsp-language-id-configuration '(just-mode . "just"))

  ;; Register just-lsp server
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection "just-lsp")
    :major-modes '(just-mode)
    :priority -1
    :server-id 'just-lsp
    :language-id "just")))
