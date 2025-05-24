(provide 'my-utils)

(defun er-copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (file-relative-name buffer-file-name (projectile-project-root)))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(defun er-copy-spec-command ()
  "Copy the current buffer file name with line and rspec command to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (file-relative-name buffer-file-name (projectile-project-root)))))
    (when filename
      (kill-new (concat "rspec " filename ":" (number-to-string (line-number-at-pos))))
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(defun er-set-indentation-to-2-spaces ()
  "Set indentation in the current buffer to 2 spaces and reindent the buffer."
  (interactive)
  (let ((tab-width 2)
        (standard-indent 2)
        (indent-tabs-mode nil))
    (indent-region (point-min) (point-max))))


(defun run-spec-vterm ()
  "Run spec in vterm"
  (interactive)
  (let ((filename (file-relative-name buffer-file-name (projectile-project-root))))
    (when filename
      (run-in-vterm (concat "rspec " filename)))))

(defun run-in-vterm-kill (process event)
  "A process sentinel. Kills PROCESS's buffer if it is live."
  (let ((b (process-buffer process)))
    (and (buffer-live-p b)
         (kill-buffer b))))

(defun run-in-vterm (command)
  "Execute string COMMAND in a new vterm.

Interactively, prompt for COMMAND with the current buffer's file
name supplied. When called from Dired, supply the name of the
file at point.

Like `async-shell-command`, but run in a vterm for full terminal features.

The new vterm buffer is named in the form `*foo bar.baz*`, the
command and its arguments in earmuffs.

When the command terminates, the shell remains open, but when the
shell exits, the buffer is killed."
  (interactive
   (list
    (let* ((f (cond (buffer-file-name)
                    ((eq major-mode 'dired-mode)
                     (dired-get-filename nil t))))
           (filename (concat " " (shell-quote-argument (and f (file-relative-name f))))))
      (read-shell-command "Terminal command: "
                          (cons filename 0)
                          (cons 'shell-command-history 1)
                          (list filename)))))
  (let ((default-directory (projectile-project-root)))
      (vterm (concat "*" command "*"))
    (set-process-sentinel vterm--process #'run-in-vterm-kill)
    (vterm-send-string command)
    (vterm-send-return)))
