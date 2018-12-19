(require 'frameshot)
(load-file "emacsair.el")

(frameshot-setup (append `((name   . "forge-status")
			   (height . 460))
			 frameshot-config-emacsair))

(require 'magit)
(magit-status-internal "~/.emacs.d/lib/magit/")
