(require 'frameshot)
(load-file "github-readme.el")

(frameshot-setup
 '((name   . "moody")
   (height . 200)
   (width  . 888)
   (shadow . ((color   . "black")
	      (opacity . 60)
	      (sigma   . 7)
	      (x       . 3)
	      (y       . 4)))
   (output . ,default-directory)))

(load-file "moody-init.el")
(find-file "moody-init.el")
(message "")
