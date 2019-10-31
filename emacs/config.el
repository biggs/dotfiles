;;; .config/doom/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; Misc Settings
(setq
    doom-font (font-spec :family "Source Code Pro" :size 15 :weight 'normal)
    doom-theme 'monokai

    ;; Theme
    monokai-highlight-line "#3A3A3A"

    ;; Fix matlab commenting
    octave-comment-char 37

    ;; Whitespace mode
    whitespace-style '(face tabs tab-mark newline-mark)
    whitespace-display-mappings '((newline-mark 10 [172 10]) (tab-mark 9 [9655 9]))

    ;; Avy switch all windows and allow all alphabetic keys
    avy-all-windows 'all-frames
    avy-keys (number-sequence ?a ?z) ; a-z for avi

    ;; Get aliases in inferior shell
    shell-command-switch "-ic"

    ;; Tex master files are called "main".
    TeX-master "main"

    ;; C style
    c-basic-offset 8
    tab-width 8
    indent-tabs-mode t
    c-default-style "linux"

    ;; Switch windows with S-<direction>
    windmove-default-keybindings t

    ;; Faster projectile
    projectile-enable-caching t

    ;; When using 'K' to lookup (non-lisp) things, use dash
    evil-lookup-func #'dash-at-point

    ;; Ranger settings
    ranger-cleanup-on-disable t
    ranger-ignored-extensions '("mkv" "iso" "mp4" "DS_Store" "pdf")
    ranger-max-preview-size 1
    ranger-dont-show-binary t

    ;; Simple Org options
    org-pandoc-options-for-latex-pdf '((pdf-engine . "xelatex"))
    org-highlight-latex-and-related '(latex script entities)

    default-input-method 'math
)

;; Disable evil in info windows
(evil-set-initial-state 'info-mode 'emacs)

;; Maximise on startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))




;; Extra keybindings

;; Avy
(define-key evil-normal-state-map (kbd "s") 'evil-avy-goto-word-or-subword-1)
(define-key evil-normal-state-map (kbd "S") 'evil-avy-goto-char)

;; Helm
(define-key evil-normal-state-map (kbd "C-s") 'helm-swoop)
(define-key evil-normal-state-map (kbd "C-S-s") 'helm-multi-swoop-all)
(define-key evil-normal-state-map (kbd "C-]") 'helm-projectile-rg)

;; Misc.
(define-key evil-normal-state-map (kbd "C-e") 'end-of-line)
(define-key evil-normal-state-map (kbd "C-a") 'beginning-of-line-text)
(define-key evil-normal-state-map (kbd "<C-tab>") 'evil-window-next)
(define-key evil-normal-state-map (kbd "K") 'evil-lookup)

;; Function keys
(define-key evil-normal-state-map (kbd "<f5>") 'compile)
(define-key evil-normal-state-map (kbd "<f8>") 'org-capture)
(define-key evil-normal-state-map (kbd "<f9>") 'org-agenda)





;; Make the compilation window automatically disappear - from enberg on #emacs
(defun my-comp-finish (buf str)
  (if (null (string-match ".*exited abnormally.*" str))
      ;;no errors, make the compilation window go away after a second
      (progn
        (run-at-time
          "1 sec" nil 'delete-windows-on
          (get-buffer-create "*compilation*"))
        (message "No Compilation Errors!"))))
(add-hook 'compilation-finish-functions 'my-comp-finish)





;; Custom keybindings for ORG Mode
(defun lookup-osx-dict-app () "Search for word at point in Mac dictionary"
        (interactive)
        (call-process      ; call and disown "open" with formatted arg
        "open" nil 0 nil
        (format "dict:://%s" (thing-at-point 'word))))

(defun org-add-keybinds ()
  ;; Use K to lookup in OSX in org mode
  (setq-local evil-lookup-func #'lookup-osx-dict-app)

  ;; Org mode allow Pandeoec PDF export with <f5>. Also use xelatex by default.
  (evil-local-set-key 'normal (kbd "<f5>") 'org-pandoc-export-to-latex-pdf)

  ;; t for selecting todo state
  (evil-local-set-key 'normal (kbd "t") 'org-todo)
)
(add-hook 'org-mode-hook 'org-add-keybinds)

(add-hook 'anki-editor-mode-hook (evil-local-set-key 'normal (kbd "C-S-c") 'anki-editor-cloze-region))





;; Setup ORG-REF and HELM_BIBTEX: complimentary plugins

(setq
  ;; Notes for BibTex
  org-ref-bibliography-notes "~/Dropbox/ORG/papers.org"

  ;; Set the default bibliography for both plugins
  org-ref-default-bibliography '("~/Dropbox/references.bib")
  bibtex-completion-bibliography "~/Dropbox/references.bib"

  ;; helm-bibtex finds pdf using bibtex field "file" set by zotero better-bibtex.
  ;; we set that to open with mac "open" and org-ref to get pdfs using this.
  bibtex-completion-pdf-field "file"
  bibtex-completion-pdf-open-function
  (lambda (fpath) (start-process "open" "*open*" "open" fpath))
  org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex

  ;; Custom created note format
  org-ref-note-title-format
  "* TODO %2a. %t (%y).
      :PROPERTIES:
      :Custom_ID: %k
      :AUTHOR: %9a
      :YEAR: %y
      :Interest:
      :Difficulty:
      :Tags:
      :END:
      :CITE: %l"
)




;; ORG GTD Setup
(setq
    ;; ORG TO DO setups
  org-agenda-files (list "~/Dropbox/ORG/todo/")

  org-agenda-custom-commands
  '(("w" todo "WAITING" nil)
    ("n" todo "NEXT" nil)
    ;; options: org-agenda.el:org-agenda-custom-commands-local-options
    (" " "Main Agenda View"
      ((todo "NEXT"
            ((org-agenda-overriding-header "NEXT Actions")))
      (tags "REFILE"
            ((org-agenda-overriding-header "Items to Refile")
              (org-tags-match-list-sublevels nil)))
      (agenda "" ((org-agenda-span 8)
                  (org-agenda-start-day nil)))  ;; today
      (todo "WAITING"
            ((org-agenda-overriding-header "Waiting Actions")))
      (todo "HOLD"
            ((org-agenda-overriding-header "On Hold Actions"))))))

  org-todo-keywords
  (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
          (sequence "HOLD(h)" "WAITING(w@/!)" "MAYBE(m)" "|" "CANCELLED(c)")))

  org-todo-keyword-faces
  (quote (("TODO" :foreground "red" :weight bold)
          ("NEXT" :foreground "orange" :weight bold)
          ("DONE" :foreground "green" :weight bold)
          ("MAYBE" :foreground "blue" :weight bold)
          ("HOLD" :foreground "gold" :weight bold)
          ("CANCELLED" :foreground "purple" :weight bold)
          ("WAITING" :foreground "magenta" :weight bold)))

  org-capture-templates
  (quote (("t" "todo" entry (file "~/Dropbox/ORG/todo/refile.org")
            "* TODO %?\n%U\n%a\n")))
)


;; ORG Mode Prettify
(setq
 org-pretty-entities-include-sub-superscripts t
 prettify-symbols-unprettify-at-point 'right
 )




;; Fancy input rules - add all non-conflicting characters from unicode-math-symbols list:
;; https://github.com/vspinu/math-symbol-lists/blob/master/math-symbol-lists.el
;; Everything is prefixed with ";" rather than "\", including sub and super-scripts.
;; If extra rules wanted, use form: (quail-define-rules ("\\unrhd" #X22B5) ("\\unrhd" #X22B5))
(package-initialize)
(require 'math-symbol-lists)
(quail-define-package "math" "UTF-8" "Ω" t)
(mapc (lambda (x)
        (if (cddr x)
            (quail-defrule
              ;; Remove "\" prefix if exists (not for sub/super scripts) and add ";" to all.
              (concat ";" (string-remove-prefix "\\" (cadr x)))
              (car (cddr x)))))
      (append math-symbol-list-basic math-symbol-list-extended
              math-symbol-list-subscripts math-symbol-list-superscripts))
