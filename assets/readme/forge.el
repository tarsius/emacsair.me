(require 'frameshot)
(load-file "github-readme.el")

(frameshot-setup (append `((name   . "forge-status")
			   (output . ,default-directory)
			   (height . 666))
			 frameshot-config-github-readme))

(require 'magit)
(magit-status-internal "~/.emacs.d/lib/magit/")
