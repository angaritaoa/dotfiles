;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Andres Angarita"
      user-mail-address "afao@icloud.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;;(setq doom-font (font-spec :family "JetBrains Mono" :size 13)
;;      doom-big-font (font-spec :family "JetBrains Mono" :size 13)
;;      doom-symbol-font (font-spec :family "JetBrains Mono" :size 13))
(setq doom-font (font-spec :family "SF Mono" :size 12)
      doom-big-font (font-spec :family "SF Mono" :size 12)
      doom-symbol-font (font-spec :family "SF Mono" :size 12))

;;(setq-default line-spacing 0.3)
;;(setq-default line-height 0.3)
;;(setq doom-font (font-spec :family "JetBrains Mono" :size 13 :weight 'Regular)
;;      doom-big-font (font-spec :family "JetBrains Mono" :size 12 :weight 'Light)
;;      doom-symbol-font (font-spec :family "JetBrains Mono" :size 12 :weight 'Light))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)
(setq doom-theme 'doom-one-light)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;;(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;(blink-cursor-mode 1)

;;(setq evil-normal-state-cursor '(hollow "#51afef")
;;      evil-insert-state-cursor '(bar    "#51afef")
;;      evil-visual-state-cursor '(hollow "#51afef"))

(map! :leader
      :desc "Toggle cursor here" :nv "i c" #'+multiple-cursors/evil-mc-toggle-cursor-here
      (:prefix ("j" . "jump")
       :desc "Jump line"   :n "l" #'avy-goto-line
       :desc "Jump word"   :n "c" #'evil-avy-goto-char-timer
       :desc "Jump window" :n "w" #'switch-window))

;;(setq projectile-project-search-path '("/mnt/archivos/projects" "/mnt/archivos/projects/bam")
;;      blink-cursor-blinks 0
;;      doom-themes-enable-bold t
;;      doom-themes-enable-italic t
;;      doom-themes-treemacs-theme "doom-atom"
;;      doom-themes-treemacs-enable-variable-pitch nil
;;      treemacs-width 50
;;      +zen-text-scale nil
;;      +zen-mixed-pitch-modes nil)

;;(setq-default x-stretch-cursor t)

(remove-hook 'text-mode-hook #'vi-tilde-fringe-mode)
(remove-hook 'prog-mode-hook #'vi-tilde-fringe-mode)
(remove-hook 'conf-mode-hook #'vi-tilde-fringe-mode)

(after! org
  (map! :map org-mode-map
        :n "M-j" #'org-metadown
        :n "M-k" #'org-metaup)
  (set-face-attribute 'org-document-title nil :height 1.0 :weight 'bold)
  (set-face-attribute 'org-level-1        nil :height 1.0 :weight 'bold)
  (set-face-attribute 'org-level-2        nil :height 1.0 :weight 'bold)
  (set-face-attribute 'org-level-3        nil :height 1.0 :weight 'bold)
  (set-face-attribute 'org-level-4        nil :height 1.0 :weight 'bold)
  (set-face-attribute 'org-level-5        nil :height 1.0 :weight 'bold)
  (set-face-attribute 'org-level-6        nil :height 1.0 :weight 'bold)
  (set-face-attribute 'org-level-7        nil :height 1.0 :weight 'bold)
  (setq org-startup-folded t
        org-startup-indented t
        org-adapt-indentation t
        org-pretty-entities t
        org-hide-emphasis-markers t
        org-startup-with-inline-images t
        org-image-actual-width '(500)
        org-superstar-headline-bullets-list '("●")
        org-superstar-item-bullet-alist '((?+ . ?⦁)
                                          (?* . ?⦁)
                                          (?- . ?⦁))
        org-ellipsis " ... "))

(add-to-list 'default-frame-alist '(width  . 170))
(add-to-list 'default-frame-alist '(height . 80))

(setq centaur-tabs-style "bar"
      centaur-tabs-set-bar -1
      centaur-tabs-height 38
      centaur-tabs-modified-marker "●")

(after! magit
  (setq magit-diff-refine-hunk 'all))

(setq lsp-dart-sdk-dir "~/.flutter/bin/cache/dart-sdk")
(setq lsp-dart-flutter-sdk "~/.flutter")
(setq flutter-sdk-path "~/.flutter")

(setq-default indent-tabs-mode nil) ; Asegura que se usen espacios en lugar de tabuladores
(setq-default tab-width 2)          ; Establece el ancho del tabulador visual a 2 espacios
(setq-default indent-line-function #'indent-to-column) ; Usa espacios para la indentación
(setq-default standard-indent 2)    ; Establece el incremento de indentación estándar a 2 espacios
