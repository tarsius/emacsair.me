---
layout: default
title: "Assimilate Emacs packages using Git submodules"
date: 2016-05-17 19:00:00 +0200
categories: magit
excerpt: >
  I am excited to announce the initial preview release of Borg, the
  package manager which assimilates Emacs packages as Git submodules.
---

# Assimilate Emacs packages<br> using Git submodules

[Borg][repo] is a bare-bones package manager for Emacs packages.
It provides only a few essential features and should be combined
with other tools such as [Magit], [`epkg`], [`use-package`], and
[`auto-compile`].

Borg is not intended to compete with `package.el`, which, as we all
know, makes it trivial to install additional packages.  That in turn
also makes it easier for the maintainers of these packages.

While `package.el` is a great success and the right solution for many
users, I don't use `package.el` myself because for me installing a
package usually is only the beginning.  More often than not I end up
contributing to the packages that I use, at least in some minor way.
`package.el` does not help with that.

When you install a package with `package.el`, it essentially fetches
the libraries that make up the package and then makes them available
to the current and future Emacs instances.  That's extremely useful
and convenient in itself, but once you want to start contributing to
an installed package, you have to fetch it *again*, this time using
Git (or in increasingly rare cases some other version control system)
to get the repository.  Now you can start making changes, testing them
by evaluating the affected forms or complete buffers, committing them,
and finally making them available publicly and proposing them to the
upstream maintainers.

So far so good --- having to clone the repository isn't such a big
deal.  But usually upstream doesn't merge your changes instantly.  You
might be asked to make further changes, or the proposed changes might
be rejected altogether.

What now? You could go back to the latest upstream version while you
wait for upstream to merge, or if your change was rejected you could
give up or you could increase your efforts to convince upstream of the
importance of your changes.

In my opinion it is better to just add your clone of the package's
repository to the `load-path` at least temporarily.  Unfortunately you
now use two different mechanisms to manage your packages, `package.el`
and "running directly from the Git repository".

## How I Learned to Stop Worrying and Love the Submodule

All of that isn't much of an issue if you only have to do it once or
twice, at least not if your changes end up being merged eventually.
But if you often contribute to the packages that you use, or if you
often patch packages for your own use, then it might make sense to
skip the `package.el` step altogether and to install all packages by
cloning their Git repositories and tracking these clones as
submodules.

I have been doing this manually for years, and enjoyed the additional
control I gained from not using a package manager.  Of course I used
existing tools to make this a bit easier.  `epkg` (which
I [released][20160416] a few weeks ago) helped determining a package's
upstream url and its dependencies.  Magit made it possible to update a
package by pulling inside its repository, and to conveniently inspect
the changes before actually doing so.  `auto-compile` made sure I did
not continue to use outdated byte-compiled files in case I forgot to
recompile after an update.  And `use-package` helped managing my
configuration.

So the features that were missing and which I had to perform by hand
were very few and `borg` only implements those.  For the other
features I continue to rely on the mentioned tools, and even though
`borg` does not actually depend on these or any other packages, I
recommend that users do the same.

Borg only implements the features that I was missing.  It does not
implement the features that are also absent but that I did not
actually miss.

Borg installs a package by adding its repository as a submodule of
`~/.emacs.d`.  It then proceeds to automatically compile libraries,
generate the autoload file, generate Info manuals from Texinfo
sources, and create the Info index file.  After installation and when
starting Emacs, Borg adds the appropriate directories to the `load-path`
and to `Info-directory-alist`, and loads the autoload files.

## Omitted features

And that's pretty much it.  Borg does *not* provide a mechanism for
updating packages and it does *not* deal with dependencies.  While
both of these features are usually expected in a package manager,
it turned out that I don't actually miss them much in this case.

With `package.el` you can choose to replace "the old version" with "the
new version".  If you want to know in what way they differ, then you
have to manually locate the changelog.  If you want to inspect the
changes in more detail, then you have to do so by navigating to some
web interface or, if you want to do it in the comfort of Emacs, then
you have to clone the respective repository.

With Borg and (an appropriately configured) Magit all changes can be
inspected instantly.  And not only that, you are not forced to choose
from two versions, "the old" and "the new".  You can instead choose to
use the tip of the maintenance branch or that of the development
branch, or any feature, hotfix, or personal branch for that matter.
Or some tag.  You are not even limited to branches and tags, you could
e.g. also rewind just before some commit that introduced a regression
or a change you hope will be reverted.  Or you could temporarily or
permanently revert the offending commit and still continue to pull
further upstream changes.  It's really all up to you.

Like there is no single "current version", there often exists no
single "definite set of dependencies" of a package, which is right for
everyone.  In light of that, I have chosen to omit dependency handling
from Borg.  In practice this means that before installing a package
you should consult the dependency tree using `epkg-describe-package`
and that you then might have to invoke `borg-assimilate` a few (but
only very rarely more than three) times, instead of just once.  That
is a bit inconvenient, but I hope that it is a price you are willing
to pay.

## Current status

Borg certainly isn't for everyone, but if you do like Git and possibly
already use submodules to install Emacs packages (or at least have not
already dismissed submodules altogether due to the sharp edges of the
user interface provided by `git submodule`), then it does provide some
of the missing pieces, which make this approach to package management
more convenient.

One of `git submodule`'s sharper edges is that it records very little
information about the internals of submodules.  This isn't much of a
problem when first trying out `borg` (whose setup command `make
bootstrap` partially works around the issue), but it does become an
issue once you start making your own commits and pushing them to your
own forks.  In that case it is necessary to add your own forks as
remotes of the submodules, because otherwise the recorded commits
might not even be available for checkout.  But currently `git
submodule` does not support that and so you have to do it manually.

I intend to fork `git submodule` and implement support for recording
and setting up additional remotes, as well as some other features
which would be very useful.  I will then also try to get those changes
merged into Git.  Until I have implemented these features, I can only
recommend Borg for users who are already familiar with submodules.

*Despite these shortcomings I am making a preview release of Borg
available now, in the hope that some users who already use submodules
to install Emacs packages give it a try and help my iron out the
outstanding issues before the the first stable release.*

Borg could be used to create a "starter-git" (typo intended) of sorts,
i.e. "the Emacs collective".  Configuration sets, what Spacemacs for
example calls "layers", could be provided as branches.  But that has
to wait until the above issue has been fully addressed.

[20160416]:       /2016/04/16/re-introducing-the-emacsmirror

[repo]:           https://github.com/emacscollective/borg
[manual]:         https://emacsmirror.net/manual/borg 

[`auto-compile`]: https://github.com/tarsius/auto-compile
[`epkg`]:         https://github.com/emacscollective/epkg
[`use-package`]:  https://github.com/jwiegley/use-package
[magit]:          https://github.com/magit/magit
