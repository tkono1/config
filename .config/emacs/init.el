;; Language and coding system.
(prefer-coding-system 'utf-8)
;(set-language-environment 'Japanese)
(set-locale-environment "en_US.UTF-8")
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)

;; Emacs version detection.
(defun x->bool (elt) (not (not elt)))
(setq emacs22-p (string-match "^22" emacs-version)
  emacs23-p (string-match "^23" emacs-version)
  emacs24-p (string-match "^24" emacs-version))

;; System type detection.
(setq darwin-p (eq system-type 'darwin)
  ns-p (eq window-system 'ns)
  carbon-p (eq window-system 'mac)
  linux-p (eq system-type 'gnu/linux)
  nt-p (eq system-type 'windows-nt))

;; Key mapping.
(global-set-key "\C-h" 'delete-backward-char)

;; Disable startup message.
(setq inhibit-startup-screen t)

;; Tab settings.
(setq-default tab-width 4)
(setq default-tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64
                    68 72 76 80 84 88 92 96 100 104 108 112 116 120))
(setq-default indent-tabs-mode nil)

;; Don't create backup file.
(setq backup-inhibited t)
;; Delete auto save file when quit.
(setq delete-auto-save-files t)

;; Disable toolbar.
(when window-system
  (tool-bar-mode -1))

;; Show line number.
(when emacs23-p
  (global-linum-mode t))

(when linux-p
;; Share clipboard with X.
  (when window-system
    (setq x-select-enable-clipboard t)))
