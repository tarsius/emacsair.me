(require 'frameshot)
(load-file "github-readme.el")

(frameshot-setup (append '((name   . "moody")
			   (height . 260))
			 frameshot-config-github-readme))

(mode-line-debug-mode -1)

(setq initial-buffer-choice "moody-init.el")

(load-file "moody-init.el")

(message "")
