(require 'frameshot)
(load-file "github-readme.el")

(frameshot-setup (append '((name   . "minions")
			   (height . 160))
			 frameshot-config-github-readme))

;; Undo settings from `user-init-file'.
(moody-replace-mode-line-buffer-identification 'reverse)
(moody-replace-vc-mode 'reverse)
(mode-line-debug-mode -1)

(load-file "minions-init.el")
(find-file "minions-init.el")
(message "")
