---
layout: default
title: "Re-introducing the Emacsmirror"
date: 2016-04-16 04:16:00 +0200
categories: magit
excerpt: >
  Re-introducing the Emacsmirror, a growing collection of Emacs Lisp
  packages.  All mirrored packages are available as Git repositories.
  In most cases this is done by mirroring the upstream Git repository,
  but if upstream uses something else, then the mirror nevertheless
  makes the package available as a Git repository.
---

# Re-introducing the Emacsmirror

The Emacsmirror is a growing collection of [Emacs] Lisp packages.  All
mirrored packages are available as [Git] repositories.  In most cases
this is done by mirroring the upstream Git repository, but if upstream
uses something else, then the mirror nevertheless makes the package
available as a Git repository.

<img src="https://emacsmirror.net/assets/emacsmirror.png">

One primary purpose of the Emacsmirror is to provide a comprehensive
list of available Emacs packages, including packages that have gone
out of fashion (but might later prove to be useful still).

Older efforts attempting to provide a comprehensive list of available
packages, such as the [Emacs Lisp List][ell], over time collected an
impressive list of dead links to packages that were no longer
available anywhere.

With the Emacsmirror this won't happen.  If a package's upstream
disappears, then a copy remains available on the mirror.  Once its
upstream has disappeared a package is usually moved from the
[Emacsmirror] to the [Emacsattic], where it is no longer updated. (The
Emacsattic is a Github "organization" separate from the Emacsmirror
organization, but it is considered part of the Emacsmirror project.)

If other mirrored packages still depend on a package whose upstream
has disappeared or no longer maintains the package, then it is copied
to the [Emacsorphanage].  The Emacsmirror then mirrors that repository
from the orphanage.  The orphanage repository serves as a temporary
home until someone volunteers to take over as maintainer.  While a
package is in the orphanage, the maintainer of the Emacsmirror makes
an effort to merge pull requests from users.

Note that in the past I have sometimes removed packages completely,
instead of moving them to the attic, but going forward that should
only happen in exceptional cases.

For more information about the Emacsmirror visit its
[homepage][mirrorhome].

# Browsing the database using epkg.el

The [`epkg.el`] package provides a user interface for browsing the
[Emacsmirror package database][epkgs].  It is very similar to the
interface provided by `package.el`, but there is more information and
some goodies.

Epkg itself is not a package manager, but the closely
related [Borg][borg-post] package manager makes use of it.

`epkg.el` can be installed from Melpa using `M-x install-package RET
epkg RET`.  ~~Right now Epkg unfortunately doesn't work with the
latest (or any) Emacs release, because it depends on some changes that
have not made it into a release yet.~~ [Update: Epkg requires Emacs
v25.1.]  Installation and usage instructions can be found
in [the manual][epkg-manual].

<img src="https://emacsmirror.net/assets/epkg.png">

<br/><br/>

*Page [CC BY 3.0](https://creativecommons.org/licenses/by/3.0)
by    [Jonas Bernoulli](https://emacsair.me),
image [CC BY-NC-SA 2.0](https://creativecommons.org/licenses/by-nc-sa/2.0)
by    [David Bygott](https://www.flickr.com/photos/davidbygott).*

[mirrorhome]:     https://emacsmirror.net
[Emacsmirror]:    https://github.com/emacsmirror
[Emacsattic]:     https://github.com/emacsattic
[Emacsorphanage]: https://github.com/emacsorphanage
[epkgs]:          https://github.com/emacsmirror/epkgs
[issues]:         https://github.com/emacsmirror/p/issues/new
[`epkg.el`]:      https://github.com/emacscollective/epkg
[epkg-manual]:    https://emacsmirror.net/manual/epkg

[borg-post]:      https://emacsair.me/2016/05/17/assimilate-emacs-packages-as-git-submodules
[`borg.el`]:      https://github.com/emacscollective/borg

[Emacs]: https://www.gnu.org/software/emacs/emacs.html
[Git]:   https://git-scm.com

[Melpa]: https://melpa.org
[ell]:   http://damtp.cam.ac.uk/user/sje30/emacs/ell.html
