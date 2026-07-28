(require 'package-build-badges)

;; #624195 as on https://www.gnu.org/software/emacs/
;; #2076c1 as in classic logo, https://commons.wikimedia.org/wiki/File:Emacs-logo.svg
;; #c64e3b as in classic logo, https://commons.wikimedia.org/wiki/File:Emacs-logo.svg
;; #bb3955 as in elpaa--make-badge

(package-build--write-badge-image
 "gnu-elpa" "✓" default-directory "GNU ELPA" "#2076c1")
(rename-file "gnu-elpa-badge.svg" "gnu-elpa.svg" t)

(package-build--write-badge-image
 "nongnu-elpa" "✓" default-directory "NonGNU ELPA" "#bb3955")
(rename-file "nongnu-elpa-badge.svg" "nongnu-elpa.svg" t)
