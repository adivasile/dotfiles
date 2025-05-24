(provide 'my-js)

;; JavaScript/TypeScript/React LSP configuration
(after! lsp-mode
  ;; TypeScript/JavaScript server setup
  (setq lsp-typescript-preferences-include-package-json-auto-imports "on")
  (setq lsp-typescript-suggest-auto-imports t)
  (setq lsp-typescript-preferences-quote-style "double")
  (setq lsp-javascript-preferences-quote-style "double"))

;; Enable LSP for all JS/TS modes
(add-hook 'typescript-ts-mode-hook #'lsp-deferred)
(add-hook 'tsx-ts-mode-hook #'lsp-deferred)
(add-hook 'js-ts-mode-hook #'lsp-deferred)
(add-hook 'typescript-mode-hook #'lsp-deferred)  ; Fallback for non-tree-sitter
(add-hook 'js-mode-hook #'lsp-deferred)          ; Fallback for non-tree-sitter

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook  'my-web-mode-hook)
