(require 'frameshot)
(load-file "github-readme.el")

(frameshot-setup (append '((name   . "backline")
			   (height . 800))
			 frameshot-config-github-readme))

;;; backline and outline-minor-faces

;;; outline-minor-faces only
;; (advice-remove 'outline-flag-region 'backline-update)

;;; vanilla
;; (remove-hook 'outline-minor-mode-hook
;; 	     'outline-minor-faces-add-font-lock-keywords)
;; (advice-remove 'outline-flag-region 'backline-update)

;;; setup

(find-library "magit-apply")
