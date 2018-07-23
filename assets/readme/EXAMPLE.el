(require 'frameshot)
(load-file "github-readme.el")

(frameshot-setup (append '((name   . "example")
			   (height . 400))
			 frameshot-config-github-readme))

;; 1. Add code here to put Emacs into the desired state.
;; 2. cd /path/to; emacs --load EXAMPLE.el
;; 3. [f8] to take a frameshot.
