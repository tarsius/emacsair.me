(require 'frameshot)
(load-file "github-readme.el")

(frameshot-setup (append '((name   . "keycast")
			   (height . 140))
			 frameshot-config-github-readme))

;; Undo settings from `user-init-file'.
(moody-replace-mode-line-buffer-identification 'reverse)
(moody-replace-vc-mode 'reverse)

(insert "\n(keycast-mode)\n")
(keycast-mode 1)
(message "")
