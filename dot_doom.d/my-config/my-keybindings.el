(provide 'my-keybindings)

(map! :leader
      :desc "Search for file in current project and open in other window"
       "v" #'projectile-find-file-other-window)
