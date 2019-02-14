(require 'frameshot)
(load-file "emacsair.el")

(frameshot-setup (append `((name   . "transient")
			   (height . 680))
			 frameshot-config-emacsair))

(require 'transient)
(define-key transient-predicate-map [frameshot-take] 'transient--do-stay)
(define-key transient-map (kbd "<f8>") 'frameshot-take)
(define-key transient-edit-map (kbd "<f8>") 'frameshot-take)
(setq transient-highlight-mismatched-keys t)

(defun transient--pre-command ()
  (transient--debug 'pre-command)
  (cond
   ((memq this-command '(transient-update transient-quit-seq))
    (transient--pop-keymap 'transient--redisplay-map))
   ((and transient--helpp
         (not (memq this-command '(transient-quit-one
                                   transient-quit-all))))
    (cond
     ((transient-help)
      (transient--do-suspend)
      (setq this-command 'transient-suspend)
      (transient--pre-exit))
     (t
      (setq this-command 'transient-undefined))))
   ((and transient--editp
         (not (memq this-command '(transient-quit-one
                                   transient-quit-all
                                   transient-help
                                   frameshot-take
				   ))))
    (setq this-command 'transient-set-level))
   (t
    (setq transient--exitp nil)
    (when (eq (if-let ((fn (or (lookup-key transient--predicate-map
                                           (vector this-original-command))
                               (oref transient--prefix transient-non-suffix))))
                  (let ((action (funcall fn)))
                    (when (eq action transient--exit)
                      (setq transient--exitp (or transient--exitp t)))
                    action)
                (setq this-command
                      (let ((keys (this-command-keys-vector)))
                        (if (eq (aref keys (1- (length keys))) ?\C-g)
                            'transient-noop
                          'transient-undefined)))
                transient--stay)
              transient--exit)
      (transient--pre-exit)))))

(require 'magit)
(magit-status-internal "~/.emacs.d/lib/transient/")
