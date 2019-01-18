(require 'frameshot)
(load-file "github-readme.el")

(frameshot-setup (append '((name   . "example")
			   (height . 400))
			 ;; If you don't use this, then don't forget to
			 ;; add: (output . ,default-directory) instead.
			 frameshot-config-github-readme))

;; 1. Add code here to put Emacs into the desired state.
;; 2. cd /path/to; emacs --load EXAMPLE.el
;; 3. [f8] to take a frameshot.

;; Since you are here, these are the key bindings:
;; [f6] frameshot-setup
;; [f7] frameshot-clear
;; [f8] frameshot-take
