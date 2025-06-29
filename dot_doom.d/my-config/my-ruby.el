(provide 'my-ruby)

(after! lsp-mode
  (setq lsp-disabled-clients '(ruby-ls typeprof-ls rubocop-ls))
  (setq rubocop-autocorrect-command "rubocop -A --format emacs")


  ;; Ruby LSP configuration with addons
  (setq lsp-ruby-lsp-use-bundler t)
  (setq lsp-ruby-lsp-server-command '("bundle" "exec" "ruby-lsp"))

  ;; Enable addons and full indexing
  (setq lsp-ruby-lsp-initialization-options
        '((enabledFeatures . ["documentSymbols"
                             "documentHighlights"
                             "documentLink"
                             "hover"
                             "inlayHint"
                             "semanticHighlighting"
                             "completion"
                             "codeLens"
                             "diagnostics"
                             "selectionRanges"
                             "foldingRanges"])
          (experimentalFeaturesEnabled . t)
          (addons . ["ruby-lsp-rails" "ruby-lsp-rspec"])  ; Enable addons
          (indexing . ((includedPatterns . ["**/*.rb"])
                      (excludedPatterns . ["tmp/**/*" "log/**/*" "node_modules/**/*"])
                      (excludedGems . [])))
          (featuresConfiguration . ((inlayHint . ((enableAll . t))))))))

(add-hook 'ruby-ts-mode-hook #'lsp-deferred)
(add-hook 'ruby-ts-mode-hook 'chruby-use-corresponding)
(add-hook 'ruby-ts-mode-hook 'rubocop-mode)

;; Rspec

(map! :leader
      :desc "Run RSpec at line" "m t n" #'my/run-rspec-at-line)

(defun my/run-rspec-at-line ()
  "Run rspec on current file at current line in a vterm buffer"
  (interactive)
  (let* ((current-file (buffer-file-name))
         (current-line (line-number-at-pos))
         (vterm-buffer-name "*vterm*")
         (vterm-buffer (get-buffer vterm-buffer-name))
         (vterm-window (and vterm-buffer (get-buffer-window vterm-buffer)))
         (rspec-command (format "rspec %s:%d"
                                (file-relative-name current-file (projectile-project-root))
                                current-line)))

    ;; Check if we have a file and we're in a project
    (if (and current-file (projectile-project-root))
        (cond
         ;; Case 1: vterm buffer is opened and visible
         (vterm-window
          (select-window vterm-window)
          (message "Using visible vterm buffer"))

         ;; Case 2: vterm buffer exists but not visible
         (vterm-buffer
          (split-window-right)
          (other-window 1)
          (switch-to-buffer vterm-buffer)
          (message "Using existing vterm buffer in new split"))

         ;; Case 3: no vterm buffer exists
         (t
          (split-window-right)
          (other-window 1)
          (+vterm/here nil)
          (message "Created new vterm buffer")))

      ;; Error cases
      (if (not current-file)
          (message "No file associated with current buffer")
        (message "Not in a project directory")))

    ;; Send the rspec command (outside the cond so it runs in all cases)
    (when (and current-file (projectile-project-root))
      (with-current-buffer vterm-buffer-name
        (vterm-send-string rspec-command)
        (vterm-send-return))
      (message "Running: %s" rspec-command))))


(defvar my/current-chruby-project nil)

(defun my/auto-chruby-use-corresponding ()
  "Run `chruby-use-corresponding` only when project context changes."
  (let* ((proj-root (ignore-errors (projectile-project-root)))
         (ruby-file (and proj-root
                         (locate-dominating-file proj-root ".ruby-version"))))
    (when (and ruby-file
               (not (equal proj-root my/current-chruby-project)))
      (setq my/current-chruby-project proj-root)
      (message "[chruby-debug] Switching Ruby for: %s" proj-root)
      (chruby-use-corresponding))))

(defun my/after-persp-activate (&rest _)
  "Run after workspace is fully activated."
  (run-at-time
   "0.1 sec" nil ;; optional, only if buffer is not set by the time this runs
   #'my/auto-chruby-use-corresponding))

(advice-add 'persp-activate :after #'my/after-persp-activate)
