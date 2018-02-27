(require 'frameshot)
(load-file "github-readme.el")

(frameshot-setup (append '((name   . "keycast")
			   (height . 450))
			 frameshot-config-github-readme))

(find-file "selfie.png")
(message "")
