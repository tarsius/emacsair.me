;; Usage:
;;
;; 1. Make sure "Emacs" starts out floating or the resizing would
;;    likely be lost.  For i3 add to "~/.config/i3/config
;;      for_window [title="Emacs"] floating enable, border pixel 0
;;    and reload using "$mod+Shift+c".
;;
;; 2. In the directory containing this file run:
;;      emacs --load EXAMPLE.el
;;
;; 3. Add code here to put Emacs into the desired state.
;;
;; 4. [f8] to take a frameshot.

;; Tips:
;;
;; [f6] frameshot-setup
;; [f7] frameshot-clear
;; [f8] frameshot-take
;;
;; Remember that these keys have to be pressed firmly on my keyboard.

(require 'frameshot)
(load-file "github-readme.el")

(frameshot-setup (append '((name   . "example")
			   (height . 400))
			 ;; If you don't use this, then don't forget to
			 ;; add: (output . ,default-directory) instead.
			 frameshot-config-github-readme))

;; Undo settings from `user-init-file'.
;; (moody-replace-mode-line-buffer-identification 'reverse)
;; (moody-replace-vc-mode 'reverse)
;; (mode-line-debug-mode -1)

(setq initial-buffer-choice "moody-init.el")

;; (load-file "MORE-INIT.el")

(message "")
