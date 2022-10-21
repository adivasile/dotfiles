(global-display-line-numbers-mode)
(setq inhibit-startup-screen t)
(load-theme 'dracula t)

;; hide menus
(menu-bar-mode -1)
(if (display-graphic-p)
    (progn
      (tool-bar-mode -1)
      (scroll-bar-mode -1)))
