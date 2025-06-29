;; Simple vanilla Emacs configuration
;; Basic package management setup
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)


;; Evil mode for Vim keybindings
(use-package evil
  :init (setq evil-want-integration t
              evil-want-keybinding nil)
  :config
  (evil-mode 1))
(use-package evil-collection
  :after evil
  :config (evil-collection-init))

;; General for leader style keybindings
(use-package general
  :config
  (general-create-definer my/leader-keys
    :states '(normal visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")
  (my/leader-keys
   "v" '(projectile-find-file-other-window :which-key "projectile other window")))

;; Core packages
(use-package projectile
  :init (projectile-mode 1))
(use-package perspective
  :init (persp-mode))
(use-package neotree)
(use-package vterm
  :commands vterm
  :config
  (setq vterm-shell "zsh")
  (setq vterm-max-scrollback 10000))
(use-package vertico
  :init (vertico-mode))
(use-package company
  :hook (after-init . global-company-mode))
(use-package magit)

;; Tree-sitter setup for modern syntax highlighting
(use-package treesit-auto
  :config
  (setq treesit-auto-install 'prompt)
  (global-treesit-auto-mode))

;; Ruby and JavaScript modes (Tree-sitter)
(add-to-list 'major-mode-remap-alist '(ruby-mode . ruby-ts-mode))
(add-to-list 'major-mode-remap-alist '(js-mode . js-ts-mode))
(add-to-list 'major-mode-remap-alist '(typescript-mode . typescript-ts-mode))

;; Basic UI tweaks
(load-theme 'deeper-blue t)
(global-display-line-numbers-mode t)
(menu-bar-mode -1)
(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

;; Keybindings similar to old config
(global-set-key (kbd "<C-return>")
                (lambda ()
                  (interactive)
                  (end-of-line)
                  (newline-and-indent)))
(global-set-key (kbd "<C-S-return>")
                (lambda ()
                  (interactive)
                  (previous-line)
                  (end-of-line)
                  (newline-and-indent)))

;; Org capture
(global-set-key (kbd "C-c j") (lambda () (interactive) (org-capture nil "jj")))

(provide 'init)
