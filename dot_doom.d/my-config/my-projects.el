(provide 'my-projects)

(map! :leader
      (:prefix "p"
       :desc "Open project terminals" "t" #'my/open-project-terminals))


(setq my/project-sessions
      '(
        (:name "coaching_scheduling_service"
         :path "~/Code/coaching_scheduling_service"
         :terminals (
                     (:name "coachingserver" :cmd "rails s -p 4201")))

        (:name "CoachNow.Web"
         :path "~/Code/CoachNow.Web"
         :terminals (
                     (:name "cnwebserver" :cmd "lib/shotzoom/cli/index.js server")))

        (:name "CoachNow.API"
         :path "~/Code/CoachNow.API"
         :terminals (
                     (:name "cnapiserver" :cmd "rails s -p 3005")))

        (:name "coaching_backend"
         :path "~/Code/coachind_backend"
         :terminals (
                     (:name "backendserver" :cmd "rails s -p 3003")))
        )
      )


(defun my/open-project-terminals ()
  "Open terminals for the current workspace/project based on my/project-sessions"
  (interactive)
  (let* ((current-workspace-name (+workspace-current-name))
         ;; Find matching project by workspace name
         (matching-project (cl-find-if
                           (lambda (p)
                             (string= (plist-get p :name) current-workspace-name))
                           my/project-sessions)))

    (if matching-project
        (let ((project-name (plist-get matching-project :name))
              (project-path (expand-file-name (plist-get matching-project :path)))
              (terminals (plist-get matching-project :terminals)))

          ;; Create each terminal
          (dolist (terminal terminals)
            (let* ((terminal-name (plist-get terminal :name))
                   (terminal-cmd (plist-get terminal :cmd))
                   (buffer-name (format "*%s*" terminal-name)))

              ;; Only create if it doesn't exist
              (unless (get-buffer buffer-name)
                ;; split window to the right
                (split-window-right)
                (other-window 1)
                (let ((default-directory project-path))
                  (vterm buffer-name)
                  (vterm-send-string terminal-cmd)
                  (vterm-send-return)
                  (message "Started: %s" terminal-name)))))

          (message "Opened %d terminals for workspace: %s"
                   (length terminals) project-name))

      ;; No matching project found
      (message "Workspace '%s' not found in my/project-sessions"
               current-workspace-name))))
