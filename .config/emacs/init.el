;;
;; Language and coding system.
;;
;; Set character code.
;(set-language-environment 'Japanese)
(set-locale-environment "en_US.UTF-8")
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
;;
;; }}
;;

;;
;; Backup files {{
;;
;; Don't create backup file.
(setq make-backup-files nil)
(setq backup-inhibited t)

;; Don't create auto save file.
(setq auto-save-default nil)
(setq auto-save-list-file-prefix nil)

;; Delete auto save file when quit.
(setq delete-auto-save-files t)
;;
;; }}
;;

;;
;; Key binding {{
;;
;; Enable C-h deletes one character.
(global-set-key "\C-h" 'delete-backward-char)
(keyboard-translate ?\C-h ?\C-?)
(global-set-key "\C-h" nil)

;; C-k deletes whole line.
(setq kill-hole-line t)

;; Set undo.
(global-set-key "\C-z" 'undo)

;; Tab settings.
(setq-default tab-width 4)
(setq default-tab-width 4)

;; Disable tab-indent mode.
(setq-default indent-tabs-mode nil)

;; Replace "yes or no" to "y or n".
(fset 'yes-or-no-p 'y-or-n-p)
;;
;; }}
;;

;;
;; Visualize {{
;;
;; Disable startup message.
(setq inhibit-startup-screen 1)

;; Disable initial scratch  message.
(setq initial-scratch-message "")
(setq initial-scratch-message nil)

;; Disable error beep.
(setq inhibit-startup-message t)

;; Disable toolbar in Window mode.
(if window-system
    (tool-bar-mode -1))

;; Disable menubar.
(menu-bar-mode -1)

;; Show line number.
(require 'linum)
(global-linum-mode 1)
(setq linum-format "%3d")
(set-face-attribute 'linum nil
    :foreground "#a9a9a9"
    :background "#404040")
;;
;; }}
;;

;;
;; Sound {{
;;
;; Disable error bell.
(setq ring-bell-function 'ignore)
;;
;; }}
;;

;;
;; Mode line {{
;;
    
;; Show line number.
(line-number-mode t)

;; Show line feed code.
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")
(setq eol-mnemonic-undecided "(?)")

;; Show filesize.
(size-indication-mode t)

;; Set colors.
(set-face-attribute 'mode-line nil
    :foreground "LightGray"
    :background "DarkGreen")
;;
;; }}
;;
