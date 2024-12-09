;;  Michael Steeves's .emacs file.
;;
;;  The previous iteration was based off of the emacs-starter-kit, and had a lot of stuff in there that wasn't really needed, it was just there. Rebooting the whole thing.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  01 For basic package management
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/"))
      gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; Ensure use-package is there
(condition-case nil
    (require 'use-package)
  (file-error
   (require 'package)
   (package-initialize)
   (package-refresh-contents)
   (package-install 'use-package)
   (setq use-package-always-ensure t)
   (require 'use-package)))

;; Put all Emacs customize variables & faces in its own file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  02 Name and e-mail
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq user-full-name "Michael Steeves"
      user-mail-address "michael@steeves.io")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  10 Appearance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(menu-bar-mode 0)
(setq column-number-mode t)

(when window-system
  (set-fringe-style 0)
  (set-cursor-color "red")
  (set-scroll-bar-mode nil)
  (tool-bar-mode 0)
  (set-face-attribute 'default nil
                      :family "Inconsolata Nerd Font Mono"
                      :height 141
                      :weight 'normal))

(use-package gruvbox-theme
  :ensure t
  :init
  (load-theme 'gruvbox-dark-hard t))

(use-package doom-modeline
  :ensure t
  :hook
  (after-init . doom-modeline-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 20 Global shortcuts and settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Treat 'y' or <CR> as yes, 'n' as no.
(fset 'yes-or-no-p 'y-or-n-p)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 25 Reading & writing files
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Tell emacs to skip backup files
(setq make-backup-files nil)
;; Yes, I want large files
(setq large-file-warning-threshold 150000000)

;; Rename current buffer, as well as doing the related version control
;; commands to rename the file.
(defun rename-this-buffer-and-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message
           "File '%s' successfully renamed to '%s'"
           filename
           (file-name-nondirectory new-name))))))))
(global-set-key (kbd "C-x C-r") 'rename-this-buffer-and-file)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 30 White space
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq tab-width 2)
(setq-default indent-tabs-mode nil)

;; This disables bidirectional text to prevent "trojan source"
;; exploits, see https://www.trojansource.codes/
(setf (default-value 'bidi-display-reordering) nil)

;; Prefer UTF 8, but don't override current encoding if specified
;; (unless you specify a write hook).
(prefer-coding-system 'utf-8-unix)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 40 Version control
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Editing VC log messages
(add-hook 'log-edit-hook (lambda () (flyspell-mode 1)))

(use-package magit
  :ensure t
  :config
  (setq magit-log-arguments '("-n256" "--graph" "--decorate" "--color")
        ;; Show diffs per word, looks nicer!
        magit-diff-refine-hunk t))

;;(use-package git-gutter+
;;  :ensure t
;;  :config
;;  (setq git-gutter+-disabled-modes '(org-mode))
;;  ;; Move between local changes
;;  (global-set-key (kbd "M-<up>") 'git-gutter+-previous-hunk)
;;  (global-set-key (kbd "M-<down>") 'git-gutter+-next-hunk))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50 Text buffers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package ispell
  :init
  (setq ispell-program-name "aspell"
        ispell-list-command "list"
        ispell-dictionary "english"
        ispell-personal-dictionary "~/.aspell.en.pws"
        flyspell-auto-correct-binding (kbd "<S-f12>")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 70 LSP and dependent packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; As listed on https://github.com/emacs-lsp/lsp-java#quick-start
(use-package projectile
 :ensure t)
(use-package counsel-projectile
  :after projectile
  :bind
  (("C-c p f" . counsel-projectile-find-file)))
(use-package flycheck
 :ensure t)
(use-package yasnippet
  :ensure t
  :config
  (setq yas/root-directory '("~/.emacs.d/snippets")
        yas-indent-line 'fixed)
  (yas-global-mode)
  )

(use-package lsp-mode
  :hook ((lsp-mode . lsp-enable-which-key-integration))
  :config
  (setq
   lsp-enable-file-watchers nil
   lsp-headerline-breadcrumb-enable nil
   )

  ;; Performance tweaks, see
  ;; https://github.com/emacs-lsp/lsp-mode#performance
  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 1024 1024)) ;; 1mb
  (setq lsp-idle-delay 0.500)
  )
(use-package hydra
 :ensure t)
(use-package company
  :ensure t
  :config
  (global-set-key (kbd "<C-return>") 'company-complete))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 80 R
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package ess
  :ensure t
  :init (require 'ess-site))
(use-package polymode
  :ensure t)
(use-package poly-markdown
  :ensure t)
(use-package poly-R
  :ensure t)

;; 82 BASH
(use-package lsp-mode
  :commands lsp
  :hook
  (sh-mode . lsp)

  :bind
  (:map lsp-mode-map
        (("\C-\M-g" . lsp-find-implementation)
         ("M-RET" . lsp-execute-code-action)))
  )

(setq sh-basic-offset 2
      sh-indentation 2)

;; snippets, please
(add-hook 'sh-mode-hook 'yas-minor-mode)

;; on the fly syntax checking
(add-hook 'sh-mode-hook 'flycheck-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 84 YAML
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package yaml-mode
 :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 85 Org
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package org
  :init
  (setq org-clock-mode-line-total 'today
        org-fontify-quote-and-verse-blocks t
        org-indent-mode t
        org-return-follows-link t
        org-startup-folded 'content
        org-todo-keywords '((sequence "TODO(t)" "STARTED(s)" "WAITING(w)" "PR(p)" "|" "MERGED(m)" "DONE(d)" "CANCELLED(c)" "DELEGATED(g)"))
        )

  :config
  (add-hook 'org-mode-hook 'org-indent-mode)

  :bind
  (("\C-ca" . org-agenda)
   ("\C-ct" . org-capture)
   ("\C-cl" . tkj/org-file-of-the-day))
   ("\C-cu" . tkj/org-update-agenda-files))

(use-package org-bullets
  :ensure t
  :init
  (setq org-bullets-bullet-list '("❯" "❯❯" "❯❯❯" "❯❯❯❯" "❯❯❯❯❯"))

  :config
  (add-hook 'org-mode-hook 'org-bullets-mode))
