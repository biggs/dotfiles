;; -*- no-byte-compile: t; -*-
;;; .config/doom/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)
(package! math-symbol-lists)
(package! anki-editor)
(package! dash-at-point)
(package! monokai-theme)
(package! org-ref)
(package! openwith)
(package! copilot
  :recipe (:host github :repo "zerolfx/copilot.el" :files ("*.el" "dist")))
