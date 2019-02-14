(require 'frameshot)
(load-file "github-readme.el")

(frameshot-setup (append `((name   . "transient")
			   (height . 680))
			 frameshot-config-github-readme))

(require 'transient)
(define-key transient-predicate-map [frameshot-take] 'transient--do-stay)
(define-key transient-map (kbd "<f8>") 'frameshot-take)
(define-key transient-edit-map (kbd "<f8>") 'frameshot-take)

(require 'magit)
(magit-status-internal "~/.emacs.d/lib/transient/")
