(require 'frameshot)

(set-fringe-mode 0)

(frameshot-setup `((name   . "git-scm-git")
		   (width  . ,(* 2 588))
		   (height . ,(* 2 332))
                   (left-fringe-width  . 0)
                   (right-fringe-width . 0)
		   (output . ,default-directory)))

;; FIXME That should have happened above.
(set-frame-width (selected-frame) (* 2 588) nil t)

(require 'magit)

(cd "~/.emacs.d/lib/magit/")
(magit-status)

;;  (* 2 588)
;;  (* 2 322)
