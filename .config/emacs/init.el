;;
;; Language and coding system {{
;;
;; Set character code.
;(set-language-environment 'Japanese)
(set-locale-environment nil)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
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
;; Competion {{
;;
;; Ignore Upper-lower case when completion.
(setq completion-ignore-case t)

;;
;; }}
;;

;; Keep location when saved.
(require 'saveplace)
(setq-default save-place t)

;;
;; Key binding {{
;;
;;
;; Modify Meta-key.
(when (eq system-type 'darwin)
    ;; Left Command key.
    (setq mac-command-modifier 'meta)
    ;; Left Option key.
    (setq mac-option-modifier 'alt)
)

(when (eq system-type 'gnu/linux)
    ;(setq mac-command-modifier 'meta)
)

(when (eq system-type 'windows-nt)
    (setq w32-alt-is-meta t)
)

;; Enable C-h deletes one character.
(global-set-key (kbd "C-h") 'delete-backward-char)
(keyboard-translate ?\C-h ?\C-?)
(global-set-key (kbd "C-h") nil)

;; C-k deletes whole line.
(setq kill-hole-line t)

;; Set go to line.
(global-set-key (kbd "M-g") 'goto-line)

;; Set undo.
(global-set-key (kbd "C-z") 'undo)

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

;; Disable startup message.
(setq inhibit-startup-message t)

;; Disable toolbar.
(if (not window-system) (progn
    (menu-bar-mode -1)
))

(if window-system (progn
    (tool-bar-mode 0)
    (menu-bar-mode -1)
    (set-scroll-bar-mode 'right)
))

;; Show matched brackets.
(show-paren-mode 1)
(setq show-paren-delay 0)
(setq show-paren-style 'parenthesis)
(set-face-attribute 'show-paren-match nil
    :background 'unspecified
    :foreground 'unspecified
    :underline "#ffff00")

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
    :foreground "Gray"
    :background "DarkGreen")
;;
;; }}
;;

;;
;; Package system {{
;;
(require 'package)
(package-initialize)

;;
;; }}
;;
