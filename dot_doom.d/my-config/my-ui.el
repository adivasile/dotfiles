(provide 'my-ui)

(setq doom-theme 'doom-molokai)
(setq doom-font (font-spec :family "MesloLGS NF" :size 14))
(setq display-line-numbers-type t)

;; Better window management
(setq split-width-threshold 120)
(setq split-height-threshold nil)

;; Smoother scrolling
(setq scroll-margin 5
      scroll-conservatively 101
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01
      scroll-preserve-screen-position t)

;; Better modeline
(after! doom-modeline
  (setq doom-modeline-height 28
        doom-modeline-buffer-file-name-style 'relative-from-project
        doom-modeline-major-mode-icon t))


(use-package! highlight-indent-guides
  :hook (prog-mode . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-responsive 'top))

(use-package! rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
